import Foundation
import Datadog
import DatadogCrashReporting
import MotorwayAPI

public class DatadogAnalytics: MotorwayAnalyticsProtocol {

    public init(isProduction: Bool) {
        /// datadog 🐶
        Datadog.initialize(
            appContext: .init(),
            trackingConsent: .granted,
            configuration: Datadog.Configuration
                .builderUsing(
                    rumApplicationID: "d2e47e78-3a3e-403e-a14a-c0653174e0a4",
                    clientToken: "pub0ad92f645245561426ba4222b0c9a75a",
                    environment: isProduction ? "production" : "staging"
                )
                .set(endpoint: .eu1)
                .trackRUMLongTasks()
                .trackBackgroundEvents()
                .enableCrashReporting(using: DDCrashReportingPlugin())
                .trackURLSession(firstPartyHosts: [
                    "jrwirbsnye.execute-api.eu-west-1.amazonaws.com",
                    "api.stage.motorway.co.uk",
                    "stage.photo-uploader.motorway.co.uk",
                    "fzmrcs00vf.execute-api.eu-west-1.amazonaws.com",
                    "api.motorway.co.uk",
                    "photo-uploader.motorway.co.uk"])
                .build()
        )

        // Datadog.verbosityLevel = .debug
        Global.rum = RUMMonitor.initialize()
    }

    public func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params? = nil) {

        switch eventType {
        case .viewAppear:
            Global.rum.startView(key: name.value, name: name.value, attributes: getPrettyPrintContent(content: eventParams?.content) ?? [:])
        case .viewDisappear:
            Global.rum.stopView(key: name.value, attributes: getPrettyPrintContent(content: eventParams?.content) ?? [:])
        case .customInfo, .customError:
            Global.rum.addUserAction(type: .custom, name: name.value, attributes: getPrettyPrintContent(content: eventParams?.content) ?? [:])
        case .buttonPress:
            Global.rum.addUserAction(type: .tap, name: name.value, attributes: getPrettyPrintContent(content: eventParams?.content) ?? [:])
        default:
            #if DEBUG
            print("No event logged for eventType:\(eventType) in datadog")
            #endif
            return
        }
    }

    public func sendError(error: Error, name: MotorwayAnalytics.Event? = nil) {

        guard let name else {
            Global.rum.addError(error: error)
            return
        }

        switch error {
        case let error as MotorwayError:
            sendError(name: name, errorDescription: "mw-" + error.dataDogType, content: ["error-description": error.description])
        default:
            self.sendError(name: name, errorDescription: error.localizedDescription)
        }
    }

    public func sendError(name: MotorwayAnalytics.Event,
                          errorDescription: String? = nil,
                          content: [String: Any]? = nil,
                          source: MotorwayAnalytics.Source? = .custom) {
        Global.rum.addError(message: name.value,
                            type: errorDescription,
                            source: getSource(source: source),
                            attributes: getPrettyPrintContent(content: content) ?? [:])
    }

    public func setUserInfo(content: [String: Any]) {
        guard let extractInfo = content as? [AttributeKey: AttributeValue] else {
            return
        }
        Datadog.setUserInfo(extraInfo: extractInfo)
    }
}

extension DatadogAnalytics {

    func getPrettyPrintContent(content: [String: Any]?) -> [AttributeKey: AttributeValue]? {
        guard let content else {
            return nil
        }
        return content as? [AttributeKey: AttributeValue]
    }

    func getSource(source: MASource? = .custom) -> RUMErrorSource {
        switch source {
        case .network:
            return .network
        case .console:
            return .console
        default:
            return .custom
        }
    }
}

public extension MotorwayError {
    var dataDogType: String {
        switch self {
        case .unhandled: return "unhandled"
        case .badRequest: return "bad-request"
        case .unauthorized: return "unauthorized"
        case .forbidden: return "forbidden"
        case .notFound: return "not-found"
        case .unprocessableEntity: return "unprocessable-entity"
        case .clientError: return "client-error"
        case .serverError: return "server-error"
        case .invalidURL: return "invalid-url"
        case .invalidData: return "invalid-data"
        case .decodingError: return "decoding-error"
        }
    }
}

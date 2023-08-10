import Foundation
import Datadog
import DatadogCrashReporting

public class DatadogAnalytics: MotorwayAnalyticsProtocol {

    public init(config: DatadogConfig) {

        /// datadog 🐶
        Datadog.initialize(
            appContext: .init(),
            trackingConsent: .granted,
            configuration: Datadog.Configuration
                .builderUsing(
                    rumApplicationID: config.rumApplicationID,
                    clientToken: config.clientToken,
                    environment: config.environment
                )
                .set(endpoint: .eu1)
                .trackRUMLongTasks()
                .trackBackgroundEvents()
                .enableCrashReporting(using: DDCrashReportingPlugin())
                .trackURLSession(firstPartyHosts: config.firstPartyHosts)
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

import Foundation
import FirebaseAnalytics

public class FirebaseAnalytics: MotorwayAnalyticsProtocol {

    public init() {}

    public func sendEvent(eventType: MotorwayAnalytics.EventType, content: [String: Any]?) {
        guard let fbEventType = getFirebaseEventType(eventType: eventType) else {
            #if DEBUG
            print("eventType:\(eventType) has no corresponding Firebase eventType.")
            #endif
            return
        }
        Analytics.logEvent(fbEventType.value, parameters: content ?? [:])
    }

    public func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params? = nil) {
        guard let eventParams else {
            Analytics.logEvent(name.value, parameters: [:])
            return
        }

        guard let fbEventType = getFirebaseEventType(eventType: eventType) else {
            #if DEBUG
            print("eventType:\(eventType) has no corresponding Firebase eventType.")
            #endif
            return
        }

        var parameters: [String: Any] = eventParams.content ?? [:]
        if let pageName = eventParams.pageName {
            parameters["page"] = pageName
        }
        parameters["event_name"] = name.value

        Analytics.logEvent(fbEventType.value, parameters: parameters)
    }

    public func sendError(error: Error, name: MotorwayAnalytics.Event? = nil) {
        Analytics.logEvent(MotorwayAnalytics.FirebaseEventType.error.value, parameters: ["content": error.localizedDescription ])
    }

    public func sendError(name: MotorwayAnalytics.Event,
                          errorDescription: String?,
                          content: [String: Any]?,
                          source: MotorwayAnalytics.Source?) {
        Analytics.logEvent(MotorwayAnalytics.FirebaseEventType.error.value,
                           parameters: content ?? [:]
                          )
    }

    public func setUserInfo(id: String) {
        Analytics.setUserID(id)
    }
}

extension FirebaseAnalytics {

    func getFirebaseEventType(eventType: MotorwayAnalytics.EventType) -> MotorwayAnalytics.FirebaseEventType? {
        switch eventType {
        case .viewAppear:
            return MotorwayAnalytics.FirebaseEventType.pageView
        case .buttonPress:
            return MotorwayAnalytics.FirebaseEventType.buttonPress
        case .enquiryCreated:
            return MotorwayAnalytics.FirebaseEventType.enquiryCreated
        case .customInfo:
            return MotorwayAnalytics.FirebaseEventType.info
        case .customError:
            return MotorwayAnalytics.FirebaseEventType.error
        case .viewDisappear:
            return nil
        case .offerSelected:
            return MotorwayAnalytics.FirebaseEventType.offerSelected
        case .interaction:
            return MotorwayAnalytics.FirebaseEventType.interaction
        case .profileComplete:
            return MotorwayAnalytics.FirebaseEventType.profileComplete
        }
    }
}

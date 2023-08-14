import Foundation

public protocol MotorwayAnalyticsProvider {

    func sendEvent(eventType: MotorwayAnalyticsEventType, name: MotorwayAnalyticsEvent, eventParams: MotorwayAnalyticsParams?)
    func sendEvent(eventType: MotorwayAnalyticsEventType, content: [String: Any]?)
    func sendError(error: Error, name: MotorwayAnalyticsEvent?)
    func sendError(name: MotorwayAnalyticsEvent,
                   errorDescription: String?,
                   content: [String: Any]?,
                   source: MotorwatAnalyticsSource?)
    func setUserInfo(id: String)
    func setUserInfo(content: [String: Any])
}

public extension MotorwayAnalyticsProvider {

    func sendEvent(eventType: MotorwayAnalyticsEventType, name: MotorwayAnalyticsEvent, eventParams: MotorwayAnalyticsParams?) {}
    func sendEvent(eventType: MotorwayAnalyticsEventType, content: [String: Any]?) {}
    func setUserInfo(id: String) {}
    func setUserInfo(content: [String: Any]) {}
    func sendError(error: Error, name: MotorwayAnalyticsEvent?) {}
    func sendError(name: MotorwayAnalyticsEvent,
                   errorDescription: String?,
                   content: [String: Any]?,
                   source: MotorwatAnalyticsSource?) {}

    func sendEvent(eventType: MotorwayAnalyticsEventType, name: MotorwayAnalyticsEvent) {
        self.sendEvent(eventType: eventType, name: name, eventParams: nil)
    }

    func sendEvent(eventType: MotorwayAnalyticsEventType) {
        self.sendEvent(eventType: eventType, content: nil)
    }

    func sendError(error: Error) {
        self.sendError(error: error, name: nil)
    }

    func sendError(name: MotorwayAnalyticsEvent, errorDescription: String? = nil, content: [String: Any]? = nil) {
        self.sendError(name: name, errorDescription: errorDescription, content: content, source: .custom)
    }
}

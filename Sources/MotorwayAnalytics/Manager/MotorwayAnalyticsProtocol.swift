import Foundation

public protocol MotorwayAnalyticsProtocol {

    func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params?)
    func sendEvent(eventType: MotorwayAnalytics.EventType, content: [String: Any]?)
    func sendError(error: Error, name: MotorwayAnalytics.Event?)
    func sendError(name: MotorwayAnalytics.Event,
                   errorDescription: String?,
                   content: [String: Any]?,
                   source: MotorwayAnalytics.Source?)
    func setUserInfo(id: String)
    func setUserInfo(content: [String: Any])
}

public extension MotorwayAnalyticsProtocol {

    func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params?) {}
    func sendEvent(eventType: MotorwayAnalytics.EventType, content: [String: Any]?) {}
    func setUserInfo(id: String) {}
    func setUserInfo(content: [String: Any]) {}
    func sendError(error: Error, name: MotorwayAnalytics.Event?) {}
    func sendError(name: MotorwayAnalytics.Event,
                   errorDescription: String?,
                   content: [String: Any]?,
                   source: MotorwayAnalytics.Source?) {}

    func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event) {
        self.sendEvent(eventType: eventType, name: name, eventParams: nil)
    }

    func sendEvent(eventType: MotorwayAnalytics.EventType) {
        self.sendEvent(eventType: eventType, content: nil)
    }

    func sendError(error: Error) {
        self.sendError(error: error, name: nil)
    }

    func sendError(name: MotorwayAnalytics.Event, errorDescription: String? = nil, content: [String: Any]? = nil) {
        self.sendError(name: name, errorDescription: errorDescription, content: content, source: .custom)
    }
}

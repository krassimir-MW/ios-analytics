import Foundation

public class MotorwayAnalyticsManager {

    let analyticsProviders: [MotorwayAnalyticsProtocol]

    public init(providers: [MotorwayAnalyticsProtocol]) {
        self.analyticsProviders = providers
    }
}

extension MotorwayAnalyticsManager: MotorwayAnalyticsProtocol {

    public func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params? = nil) {
        for provider in analyticsProviders {
            provider.sendEvent(eventType: eventType, name: name, eventParams: eventParams)
        }
    }

    public func sendEvent(eventType: MotorwayAnalytics.EventType, content: [String: Any]? = nil) {
        for provider in analyticsProviders {
            provider.sendEvent(eventType: eventType, content: content)
        }
    }

    public func sendError(error: Error, name: MotorwayAnalytics.Event? = nil) {
        for provider in analyticsProviders {
            provider.sendError(error: error, name: name)
        }
    }

    public func sendError(name: MotorwayAnalytics.Event,
                          errorDescription: String? = nil,
                          content: [String: Any]? = nil,
                          source: MotorwayAnalytics.Source? = .custom) {
        for provider in analyticsProviders {
            provider.sendError(name: name, errorDescription: errorDescription, content: content, source: source)
        }
    }

    public func setUserInfo(id: String) {
        for provider in analyticsProviders {
            provider.setUserInfo(id: id)
        }
    }

    public func setUserInfo(content: [String: Any]) {
        for provider in analyticsProviders {
            provider.setUserInfo(content: content)
        }
    }
}

public extension MotorwayAnalyticsProtocol {
    /// Returns a provider cast to the inferred return type, or nil if a match is not found
    func getProvider<T>() -> T? {
        guard let manager = self as? MotorwayAnalyticsManager else { return nil }

        return manager.analyticsProviders.compactMap { $0 as? T }.first
    }
}

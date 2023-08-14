import Foundation

public class MotorwayAnalyticsManager {
    let analyticsProviders: [MotorwayAnalyticsProvider]
    
    public init(providers: [MotorwayAnalyticsProvider]) {
        self.analyticsProviders = providers
    }
}

extension MotorwayAnalyticsManager: MotorwayAnalyticsProvider {

    public func sendEvent(eventType: MotorwayAnalyticsEventType, name: MotorwayAnalyticsEvent, eventParams: MotorwayAnalyticsParams? = nil) {
        for provider in analyticsProviders {
            provider.sendEvent(eventType: eventType, name: name, eventParams: eventParams)
        }
    }

    public func sendEvent(eventType: MotorwayAnalyticsEventType, content: [String: Any]? = nil) {
        for provider in analyticsProviders {
            provider.sendEvent(eventType: eventType, content: content)
        }
    }

    public func sendError(error: Error, name: MotorwayAnalyticsEvent? = nil) {
        for provider in analyticsProviders {
            provider.sendError(error: error, name: name)
        }
    }

    public func sendError(name: MotorwayAnalyticsEvent,
                          errorDescription: String? = nil,
                          content: [String: Any]? = nil,
                          source: MotorwatAnalyticsSource? = .custom) {
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

public extension MotorwayAnalyticsProvider {
    /// Returns a provider cast to the inferred return type, or nil if a match is not found
    func getProvider<T>() -> T? {
        guard let manager = self as? MotorwayAnalyticsManager else { return nil }
        return manager.analyticsProviders.compactMap { $0 as? T }.first
    }
}

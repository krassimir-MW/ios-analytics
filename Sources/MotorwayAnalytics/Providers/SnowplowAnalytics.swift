import Foundation
import SnowplowTracker

public class SnowplowAnalytics: MotorwayAnalyticsProtocol {
    var tracker: TrackerController?

    public init(config: SnowplowConfig) {
        tracker = Snowplow.createTracker(namespace: "appTracker", endpoint: config.endpoint) {
            TrackerConfiguration(appId: config.appId)
              .base64Encoding(false)
              .sessionContext(true)
              .platformContext(true)
              .lifecycleAutotracking(true)
              .screenViewAutotracking(true)
              .screenContext(true)
              .applicationContext(true)
              .exceptionAutotracking(true)
              .installAutotracking(true)
              .userAnonymisation(false)
        }
    }

    public func sendEvent(eventType: MotorwayAnalyticsEventType, name: MotorwayAnalyticsEvent, eventParams: MotorwayAnalyticsParams?) {
        // This method is empty because at the minute no business need to send the actual events.
    }

    public var domainUserId: String {
        tracker?.subject?.domainUserId ?? ""
    }

    public var sessionId: String {
        tracker?.session?.sessionId ?? ""
    }

    public var networkUserId: String {
        tracker?.subject?.networkUserId ?? ""
    }

    deinit {
        tracker  = nil
    }
}

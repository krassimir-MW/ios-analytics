import Foundation
import SnowplowTracker

public class SnowplowAnalytics: MotorwayAnalyticsProtocol {
    var tracker: TrackerController?

    public init(appId: String, endpoint: String) {
        tracker = Snowplow.createTracker(namespace: "appTracker", endpoint: endpoint) {
          TrackerConfiguration(appId: appId)
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

    public func sendEvent(eventType: MotorwayAnalytics.EventType, name: MotorwayAnalytics.Event, eventParams: MotorwayAnalytics.Params?) {
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
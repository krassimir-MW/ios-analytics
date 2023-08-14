import Foundation

public typealias MAEvent = MotorwayAnalyticsEvent

public protocol MotorwayAnalyticsEvent {
    var value: String { get }
}

import Foundation

public typealias MAEventType = MotorwayAnalyticsEventType

public protocol MotorwayAnalyticsEventType {
    var value: String { get }
}

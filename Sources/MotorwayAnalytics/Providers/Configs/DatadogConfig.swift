import Foundation

public struct DatadogConfig {
    let rumApplicationID: String
    let clientToken: String
    let environment: String
    let firstPartyHosts: Set<String>
}

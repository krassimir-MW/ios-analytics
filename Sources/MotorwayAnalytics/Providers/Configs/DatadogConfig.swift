import Foundation

public struct DatadogConfig {
    let rumApplicationID: String
    let clientToken: String
    let environment: String
    let firstPartyHosts: Set<String>
    
    public init(rumApplicationID: String, clientToken: String, environment: String, firstPartyHosts: Set<String>) {
        self.rumApplicationID = rumApplicationID
        self.clientToken = clientToken
        self.environment = environment
        self.firstPartyHosts = firstPartyHosts
    }
}

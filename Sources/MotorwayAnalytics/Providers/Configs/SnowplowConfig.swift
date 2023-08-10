import Foundation

public struct SnowplowConfig {
    let appId: String
    let endpoint: String
    
    public init(appId: String, endpoint: String) {
        self.appId = appId
        self.endpoint = endpoint
    }
}

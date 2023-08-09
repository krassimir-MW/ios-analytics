extension MotorwayAnalytics {

    public struct Params {
        public var pageName: String?
        public var content: [String: Any]?

        public init(pageName: String? = nil, content: [String: Any]? = nil) {
            self.pageName = pageName
            self.content = content
        }
    }
}

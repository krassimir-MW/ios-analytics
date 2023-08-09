extension MotorwayAnalytics {

    public enum EventType {
        case buttonPress
        case viewAppear
        case viewDisappear
        case enquiryCreated
        case customInfo
        case customError
        case offerSelected
        case interaction
        case profileComplete

        public var value: String {
            switch self {
            case .buttonPress:
                return "mw_button_press"
            case .viewAppear:
                return "mw_page_view"
            case .viewDisappear:
                return "mw_page_view"
            case .enquiryCreated:
                return "enquiry_created"
            case .customInfo:
                return "mw_info"
            case .customError:
                return "mw_error"
            case .offerSelected:
                return "offer_selected"
            case .interaction:
                return "mw_interaction"
            case .profileComplete:
                return "profile_complete"
            }
        }
    }

    internal enum FirebaseEventType: String {
        case buttonPress = "mw_button_press"
        case pageView = "mw_page_view"
        // when enquiry is made
        case enquiryCreated = "enquiry_created"
        case info =  "mw_info"
        case error = "mw_error"
        case offerSelected = "offer_selected"
        case interaction = "mw_interaction"
        case profileComplete = "profile_complete"

        public var value: String {
            return self.rawValue
        }
    }
}

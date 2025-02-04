import ComposableArchitecture

@Reducer
struct FormFeelingReducer {
    struct State: Equatable {
        var journal: String = ""
        var selectedActivity: String = "Working"
        var selectedPlace: String = "Outside"
    }
    
    enum Action: Equatable {
        case updateJournal(String)
        case selectActivity(String)
        case selectPlace(String)
        case saveButtonTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case routeToSuccessSubmit
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .updateJournal(text):
                state.journal = text
                return .none
                
            case let .selectActivity(activity):
                state.selectedActivity = activity
                return .none
                
            case let .selectPlace(place):
                state.selectedPlace = place
                return .none
                
            case .saveButtonTapped:
                return .send(.delegate(.routeToSuccessSubmit))
                
            case .delegate:
                return .none
            }
        }
    }
} 
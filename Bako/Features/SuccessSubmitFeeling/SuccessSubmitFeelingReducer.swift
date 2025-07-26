import ComposableArchitecture
import Foundation

@Reducer
struct SuccessSubmitFeelingReducer {
    @ObservableState
    struct State: Equatable {
        // Add any state properties if needed
    }
    
    enum Action: Equatable {
        case backToHomeButtonTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case backToHome
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backToHomeButtonTapped:
                return .send(.delegate(.backToHome))
                
            case .delegate:
                return .none
            }
        }
    }
} 

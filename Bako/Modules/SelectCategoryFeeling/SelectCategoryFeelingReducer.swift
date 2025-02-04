import ComposableArchitecture

@Reducer
struct SelectCategoryFeelingReducer {
    struct State: Equatable {
        var selectedEmotionCategory: EmotionCategory?
    }
    
    enum Action: Equatable {
        case selectEmotionCategory(EmotionCategory)
        case continueButtonTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case routeToSelectFeeling
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectEmotionCategory(category):
                state.selectedEmotionCategory = category
                return .none
                
            case .continueButtonTapped:
                return .send(.delegate(.routeToSelectFeeling))
                
            case .delegate:
                return .none
            }
        }
    }
} 
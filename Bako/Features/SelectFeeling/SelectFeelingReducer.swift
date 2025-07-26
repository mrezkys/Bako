import ComposableArchitecture
import Foundation

@Reducer
struct SelectFeelingReducer {
    @ObservableState
    struct State: Equatable {
        var selectedEmotionIndex: Int?
        var activeCircleIndex: Int?
        var currentOffset: CGSize = .zero
        var lastOffset: CGSize = .zero
        var emotions: [EmotionModel]
        var formFeeling: FormFeelingReducer.State?
        
        init(emotions: [EmotionModel]) {
            self.emotions = emotions
        }
    }
    
    enum Action: Equatable {
        case selectEmotion(Int)
        case updateActiveCircle(Int?)
        case updateOffset(CGSize)
        case setLastOffset(CGSize)
        case continueButtonTapped
        case formFeeling(FormFeelingReducer.Action)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case routeToFormFeeling
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectEmotion(index):
                state.selectedEmotionIndex = index
                return .none
                
            case let .updateActiveCircle(index):
                state.activeCircleIndex = index
                return .none
                
            case let .updateOffset(offset):
                state.currentOffset = offset
                return .none
                
            case let .setLastOffset(offset):
                state.lastOffset = offset
                return .none
                
            case .continueButtonTapped:
                state.formFeeling = FormFeelingReducer.State()
                return .send(.delegate(.routeToFormFeeling))
                
            case .formFeeling, .delegate:
                return .none
            }
        }
        .ifLet(\.formFeeling, action: \.formFeeling) {
            FormFeelingReducer()
        }
    }
} 

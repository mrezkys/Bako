import Foundation
import ComposableArchitecture

@Reducer
struct AboutReducer {
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action: Equatable {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
} 

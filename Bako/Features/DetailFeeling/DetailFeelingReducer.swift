//
//  DetailFeelingReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 08/02/25.
//

import ComposableArchitecture

@Reducer
struct DetailFeelingReducer {
    struct State: Equatable {
        let emotion: EmotionModel
        
        init(emotion: EmotionModel) {
            self.emotion = emotion
        }
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

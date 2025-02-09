import ComposableArchitecture
import Foundation
import SwiftData

@Reducer
struct FormFeelingReducer {
    @Dependency(\.userDefaults) var userDefaults
    
    struct State: Equatable {
        var journal: String = ""
        var selectedActivity: String = "Working"
        var selectedPlace: String = "Outside"
        let defaultActivities: [String] = ["Working", "Driving", "Gym", "Cleaning", "Eating"]
        let defaultPlaces: [String] = ["Outside", "Office", "Commuting", "Home"]
        var customActivities: [String] = []
        var customPlaces: [String] = []
        
        var activities: [String] {
            defaultActivities + customActivities
        }
        
        var places: [String] {
            defaultPlaces + customPlaces
        }
        
        var selectedEmotion: EmotionModel?
        var currentDate: Date = Date()
        var modelContext: ModelContext?
        
        init(selectedEmotion: EmotionModel? = nil, modelContext: ModelContext? = nil) {
            self.selectedEmotion = selectedEmotion
            self.modelContext = modelContext
        }
    }
    
    enum Action: Equatable {
        case onAppear
        case updateJournal(String)
        case selectActivity(String)
        case selectPlace(String)
        case saveButtonTapped
        case delegate(Delegate)
        case addCustomActivity(String)
        case addCustomPlace(String)
        case removeCustomActivity(String)
        case removeCustomPlace(String)
        case saveEmotion
        case emotionSaved
        
        enum Delegate: Equatable {
            case routeToSuccessSubmit
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                // Load saved data when view appears
                state.customActivities = userDefaults.stringArray(forKey: "customActivities") ?? []
                state.customPlaces = userDefaults.stringArray(forKey: "customPlaces") ?? []
                
                if let lastActivity = userDefaults.string(forKey: "lastSelectedActivity") {
                    state.selectedActivity = lastActivity
                }
                if let lastPlace = userDefaults.string(forKey: "lastSelectedPlace") {
                    state.selectedPlace = lastPlace
                }
                return .none
                
            case let .updateJournal(text):
                state.journal = text
                return .none
                
            case let .selectActivity(activity):
                state.selectedActivity = activity
                userDefaults.set(activity, forKey: "lastSelectedActivity")
                return .none
                
            case let .selectPlace(place):
                state.selectedPlace = place
                userDefaults.set(place, forKey: "lastSelectedPlace")
                return .none
                
            case .saveButtonTapped:
                return .send(.saveEmotion)
                
            case .delegate:
                return .none
                
            case let .addCustomActivity(activity):
                if !state.activities.contains(activity) {
                    state.customActivities.append(activity)
                    userDefaults.set(state.customActivities, forKey: "customActivities")
                }
                return .none
                
            case let .addCustomPlace(place):
                if !state.places.contains(place) {
                    state.customPlaces.append(place)
                    userDefaults.set(state.customPlaces, forKey: "customPlaces")
                }
                return .none
                
            case let .removeCustomActivity(activity):
                if state.customActivities.contains(activity) {
                    state.customActivities.removeAll { $0 == activity }
                    userDefaults.set(state.customActivities, forKey: "customActivities")
                    // If the removed activity was selected, select the first available activity
                    if state.selectedActivity == activity {
                        state.selectedActivity = state.activities.first ?? "Working"
                    }
                }
                return .none
                
            case let .removeCustomPlace(place):
                if state.customPlaces.contains(place) {
                    state.customPlaces.removeAll { $0 == place }
                    userDefaults.set(state.customPlaces, forKey: "customPlaces")
                    // If the removed place was selected, select the first available place
                    if state.selectedPlace == place {
                        state.selectedPlace = state.places.first ?? "Outside"
                    }
                }
                return .none
                
            case .saveEmotion:
                guard let modelContext = state.modelContext,
                      var emotion = state.selectedEmotion else {
                    return .none
                }
                
                // Update emotion with form data
                emotion.journal = state.journal
                emotion.activities = state.selectedActivity
                emotion.place = state.selectedPlace
                emotion.date = state.currentDate
                
                // Save to SwiftData
                modelContext.insert(emotion)
                do {
                    try modelContext.save()
                    return .send(.emotionSaved)
                } catch {
                    print("Failed to save emotion: \(error)")
                    return .none
                }
                
            case .emotionSaved:
                return .send(.delegate(.routeToSuccessSubmit))
            }
        }
    }
} 

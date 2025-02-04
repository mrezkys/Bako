import ComposableArchitecture
import Foundation

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
        var isFormValid: Bool = false
        var showError: Bool = false
        var currentDate: Date = Date()
        
        init(selectedEmotion: EmotionModel? = nil) {
            self.selectedEmotion = selectedEmotion
            self.validateForm()
        }
        
        mutating func validateForm() {
            // Form is valid if journal is not empty and has at least 3 characters
            isFormValid = journal.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
        }
    }
    
    enum Action: Equatable {
        case onAppear
        case updateJournal(String)
        case selectActivity(String)
        case selectPlace(String)
        case saveButtonTapped
        case validateForm
        case setShowError(Bool)
        case delegate(Delegate)
        case addCustomActivity(String)
        case addCustomPlace(String)
        case removeCustomActivity(String)
        case removeCustomPlace(String)
        
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
                state.validateForm()
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
                if state.isFormValid {
                    // Here you would typically save the form data
                    return .send(.delegate(.routeToSuccessSubmit))
                } else {
                    state.showError = true
                    return .send(.setShowError(true))
                }
                
            case .validateForm:
                state.validateForm()
                return .none
                
            case let .setShowError(show):
                state.showError = show
                if show {
                    // Auto-hide error after 3 seconds
                    return .run { send in
                        try await Task.sleep(for: .seconds(3))
                        await send(.setShowError(false))
                    }
                }
                return .none
                
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
            }
        }
    }
} 

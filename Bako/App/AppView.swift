import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppReducer>
    
    var body: some View {
        NavigationStackStore(
            store.scope(state: \.path, action: \.path)
        ) {
            // Root view
            WithViewStore(store, observe: \.home) { viewStore in
                Group {
                    if let homeState = viewStore.state {
                        HomeView(
                            store: store.scope(
                                state: \.home!,
                                action: \.home
                            )
                        )
                    } else {
                        OnboardingView(
                            store: store.scope(
                                state: \.onboarding,
                                action: \.onboarding
                            )
                        )
                    }
                }
            }
        } destination: { route in
            // Destinations for other routes
            switch route {
            case .selectCategoryFeeling:
                SelectCategoryFeelingView(
                    store: store.scope(
                        state: \.selectCategoryFeeling!,
                        action: \.selectCategoryFeeling
                    )
                )
            case .selectFeeling:
                SelectFeelingView(
                    store: store.scope(
                        state: \.selectFeeling!,
                        action: \.selectFeeling
                    )
                )
            case .formFeeling:
                FormFeelingView(
                    store: store.scope(
                        state: \.formFeeling!,
                        action: \.formFeeling
                    )
                )
            case .successSubmit:
                SuccessSubmitFeelingView()
            case .tracker:
                TrackerView(
                    store: store.scope(
                        state: \.tracker!,
                        action: \.tracker
                    )
                )
            case .details(let id):
                Text("📄 Details View: \(id)")
            default:
                EmptyView()
            }
        }
    }
}

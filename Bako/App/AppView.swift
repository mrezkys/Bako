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
                        .transition(.move(edge: .trailing))
                    } else {
                        OnboardingView(
                            store: store.scope(
                                state: \.onboarding,
                                action: \.onboarding
                            )
                        )
                    }
                }
                .animation(.smooth, value: viewStore.state != nil)
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
                SuccessSubmitFeelingView(
                    store: store.scope(
                        state: \.successSubmit!,
                        action: \.successSubmit
                    )
                )
            case .tracker:
                TrackerView(
                    store: store.scope(
                        state: \.tracker!,
                        action: \.tracker
                    )
                )
            case .details(let id):
                DetailFeelingView(
                    store: store.scope(
                        state: \.detailFeeling!,
                        action: \.detailFeeling
                    )
                )
            case .about:
                AboutView(
                    store: store.scope(
                        state: \.about!,
                        action: \.about
                    )
                )
            default:
                EmptyView()
            }
        }
    }
}

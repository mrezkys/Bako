import ComposableArchitecture
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppReducer>
    
    var body: some View {
        NavigationStackStore(
            store.scope(state: \.path, action: \.path)
        ) {
            // Root view
            Group {
                if let homeState = store.home {
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
            .animation(.smooth, value: store.home != nil)
        } destination: { route in
            // Destinations for other routes
            switch route {
            case .selectCategoryFeeling:
                if let selectCategoryState = store.selectCategoryFeeling {
                    SelectCategoryFeelingView(
                        store: store.scope(
                            state: \.selectCategoryFeeling!,
                            action: \.selectCategoryFeeling
                        )
                    )
                }
            case .selectFeeling:
                if let selectFeelingState = store.selectFeeling {
                    SelectFeelingView(
                        store: store.scope(
                            state: \.selectFeeling!,
                            action: \.selectFeeling
                        )
                    )
                }
            case .formFeeling:
                if let formFeelingState = store.formFeeling {
                    FormFeelingView(
                        store: store.scope(
                            state: \.formFeeling!,
                            action: \.formFeeling
                        )
                    )
                }
            case .successSubmit:
                if let successSubmitState = store.successSubmit {
                    SuccessSubmitFeelingView(
                        store: store.scope(
                            state: \.successSubmit!,
                            action: \.successSubmit
                        )
                    )
                }
            case .tracker:
                if let trackerState = store.tracker {
                    TrackerView(
                        store: store.scope(
                            state: \.tracker!,
                            action: \.tracker
                        )
                    )
                }
            case .details(let id):
                if let detailFeelingState = store.detailFeeling {
                    DetailFeelingView(
                        store: store.scope(
                            state: \.detailFeeling!,
                            action: \.detailFeeling
                        )
                    )
                }
            case .about:
                if let aboutState = store.about {
                    AboutView(
                        store: store.scope(
                            state: \.about!,
                            action: \.about
                        )
                    )
                }
            default:
                EmptyView()
            }
        }
    }
}

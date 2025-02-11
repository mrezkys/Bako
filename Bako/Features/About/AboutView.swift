import SwiftUI
import ComposableArchitecture

struct AboutView: View {
    let store: StoreOf<AboutReducer>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // About App Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("About App")
                        .plusJakartaFont(.bold, 18)
                    Text("Bako is an emotion tracker app that helps users identify, categorize, and log their emotions.")
                        .plusJakartaFont(.regular, 14)
                        .foregroundColor(.grey)
                }
                
                // Credits Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Credits")
                        .plusJakartaFont(.bold, 18)
                    
                    // Developer
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Developer")
                            .plusJakartaFont(.medium, 16)
                        Link("Muhammad Rezky Sulihin", destination: URL(string: "https://www.linkedin.com/in/mrezkys/")!)
//                            .plusJakartaFont(.regular, 14)
                            .foregroundColor(.primaryBlue)
                    }
                    
                    // Designer
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Designer")
                            .plusJakartaFont(.medium, 16)
                        Link("Amanda Tri Utami Permatasari", destination: URL(string: "https://www.linkedin.com/in/amandatriutamipermatasari/")!)
//                            .plusJakartaFont(.regular, 14)
                            .foregroundColor(.primaryBlue)
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("About")
    }
} 

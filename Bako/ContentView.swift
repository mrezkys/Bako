//
//  ContentView.swift
//  Bako
//
//  Created by Muhammad Rezky on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
                .font(.custom("PlusJakartaSans-Bold", size: 100))

        }
        .padding()
        .onAppear{
            for family in UIFont.familyNames {
                print("Font family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print("Font name: \(name)")
                }
            }

        }
    }
}

#Preview {
    ContentView()
}

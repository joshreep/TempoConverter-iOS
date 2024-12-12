//
//  ContentView.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/23/24.
//

import SwiftUI

enum Tabs: Equatable, Hashable {
    case calculator
    case settings
}

struct ContentView: View {
    @State private var selectedTab: Tabs = .calculator

    var body: some View {
        TabView (selection: $selectedTab) {
            Tab("Calculator", systemImage: "hand.tap", value: .calculator) {
                TapTempoView()
                Divider()
                    .padding(.bottom)
            }

            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
                Divider()
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}

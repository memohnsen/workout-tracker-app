//
//  ContentView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "figure.strengthtraining.traditional")
                }
            Text("History")
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
            Text("Exercises")
                .tabItem{
                    Label("Exercises", systemImage: "dumbbell.fill")
                }
            Text("Metrics")
                .tabItem{
                    Label("Metrics", systemImage: "chart.bar")
                }
            Text("Settings")
                .tabItem{
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

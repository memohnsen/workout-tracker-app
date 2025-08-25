//
//  ContentView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI
import SwiftData
import ConvexMobile

let convex = ConvexClient(deploymentUrl: "https://youthful-labrador-295.convex.cloud")

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "figure.strengthtraining.traditional")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
            ExerciseView()
                .tabItem{
                    Label("Exercises", systemImage: "dumbbell.fill")
                }
            MetricsView()
                .tabItem{
                    Label("Metrics", systemImage: "chart.bar")
                }
            SettingsView()
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

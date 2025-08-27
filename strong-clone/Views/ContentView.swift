//
//  ContentView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI
import SwiftData
import PostHog
import Foundation
import ConvexMobile

let convex = ConvexClient(deploymentUrl: "https://youthful-labrador-295.convex.cloud")

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "figure.strengthtraining.traditional")
                }
            ExerciseView()
                .tabItem{
                    Label("Exercises", systemImage: "dumbbell.fill")
                }
            MetricsView()
                .tabItem{
                    Label("Metrics", systemImage: "chart.bar")
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let POSTHOG_API_KEY: String = ProcessInfo.processInfo.environment["POSTHOG_API_KEY"]!
        let POSTHOG_HOST: String = ProcessInfo.processInfo.environment["POSTHOG_HOST"]!

        let config = PostHogConfig(apiKey: POSTHOG_API_KEY, host: POSTHOG_HOST)
        
        PostHogSDK.shared.setup(config)

        return true
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

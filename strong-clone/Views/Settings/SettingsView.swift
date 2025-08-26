//
//  SettingsView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: ProfileView()){
                    SettingsCard(image: "person.crop.circle", title: "Profile", darkMode: .constant(colorScheme == .dark))
                }
                
                NavigationLink(destination: SubscriptionView()){
                    SettingsCard(image: "creditcard.fill", title: "Subscription", darkMode: .constant(colorScheme == .dark))
                }

                NavigationLink(destination: ContactView()){
                    SettingsCard(image: "envelope.fill", title: "Contact Us", darkMode: .constant(colorScheme == .dark))
                }
            }
//            .navigationTitle("Settings")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsCard: View{
    var image: String
    var title: String
    @Binding var darkMode: Bool

    var body: some View {
        VStack(spacing: 16) {
            
            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: image)
                        .foregroundStyle(darkMode ? Color.white : Color(.black))
                        .imageScale(.large)
                    Text(title)
                        .foregroundStyle(darkMode ? Color.white : Color(.black))
                    Spacer()
                }
                .padding()
                .background(darkMode ? Color(.secondarySystemBackground) : Color(.systemBackground))
                .cornerRadius(12)
                .frame(width: 330, height: 30)
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack{

        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SubscriptionView: View {
    var body: some View {
        VStack{
            
        }
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactView: View {
    var body: some View {
        VStack{
            
        }
        .navigationTitle("Contact Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}

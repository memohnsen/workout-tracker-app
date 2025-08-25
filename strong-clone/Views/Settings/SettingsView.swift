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
        ZStack {
            NavigationStack {
                List {
                    SettingsCard(image: "person.crop.circle", title: "Profile", darkMode: .constant(colorScheme == .dark))
                    SettingsCard(image: "creditcard.fill", title: "Subscription", darkMode: .constant(colorScheme == .dark))
                    SettingsCard(image: "envelope.fill", title: "Contact Us", darkMode: .constant(colorScheme == .dark))
                }.navigationTitle("Settings")
            }
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
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                        .imageScale(.small)
                }
                .padding()
                .background(darkMode ? Color(.secondarySystemBackground) : Color(.systemBackground))
                .cornerRadius(12)
                .frame(width: 350, height: 30)
            }
        }
    }
}

#Preview {
    SettingsView()
}

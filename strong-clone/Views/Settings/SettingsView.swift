//
//  SettingsView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct SettingsView: View {
    
    fileprivate func SettingsCard(image: String, title: String, textColor: Color) -> some View {
        return VStack(spacing: 16) {
            
            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: image)
                        .foregroundStyle(.blue)
                        .imageScale(.large)
                    Text(title)
                        .foregroundStyle(textColor)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                        .imageScale(.small)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .frame(width: 350, height: 30)
            }
        }
    }
    
    var body: some View {
        // vstack for page
        // vstack
        // profile card
        // subscription
        // dark mode
        // contact us
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 0) {
                List {
                    SettingsCard(image: "person.crop.circle", title: "Profile", textColor: .black)
                    SettingsCard(image: "creditcard.fill", title: "Subscription", textColor: .black)
                }
    
            }
        }
    }
}

#Preview {
    SettingsView()
}

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
                        .foregroundStyle(.black)
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
        @State var isDarkMode: Bool = false
        
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 0) {
                List {
                    SettingsCard(image: "person.crop.circle", title: "Profile", textColor: .black)
                    SettingsCard(image: "creditcard.fill", title: "Subscription", textColor: .black)
                    SettingsCard(image: "envelope.fill", title: "Contact Us", textColor: .black)
                    HStack{
                        Image(systemName: "moonphase.waxing.crescent")
                            .resizable()
                            .frame(width: 25)
                            .frame(height: 25)
                            .padding(.leading, 12)
                        Toggle(" Dark Mode", isOn: $isDarkMode)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

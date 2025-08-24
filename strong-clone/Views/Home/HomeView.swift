//
//  HomeView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack {
                Button("Start An Empty Workout") {
                    showAlert = true
                }.frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.padding(.horizontal, 20)

            
            HStack {
                Text("Templates").font(.title2)
                Spacer()
                
                Button("+ Template") {
                    
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}) {
                    Image(systemName: "folder")
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }.buttonStyle(.borderedProminent)
            }
            
            HStack {
                Image(systemName: "folder")
                Text("My Templates (2)")
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }.buttonStyle(.borderedProminent)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                WorkoutCard(title: "Workout 1")
                WorkoutCard(title: "Workout 2")
                WorkoutCard(title: "Workout 3")
                WorkoutCard(title: "Workout 4")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        .alert("Button Clicked", isPresented: $showAlert) {
            Button("Ok") {}
        } message: {Text("Clicked")}
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 186/255, green: 164/255, blue: 235/255))
    }
}

#Preview {
    ContentView()
}

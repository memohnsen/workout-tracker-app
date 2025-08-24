//
//  HomeView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showAlert = false
    
    let templates: [String] = ["Template 1", "Template 2", "Template 3", "Template 4"]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()

            ScrollView {
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .trailing) {
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }

                    HStack {
                        Text("Templates").font(.title2)
                        Spacer()
                        
                        Button("+ Template") {
                            
                        }.buttonStyle(.borderedProminent)
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "folder")
                        }.buttonStyle(.borderedProminent)
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "ellipsis")
                        }.buttonStyle(.borderedProminent)
                    }
                    
                    HStack {
                        Image(systemName: "folder")
                        Text("My Templates")
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(templates, id: \.self) {workout in
                            WorkoutCard(title: workout)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            
            .alert("Button Clicked", isPresented: $showAlert) {
                Button("Ok") {}
            } message: {Text("Clicked")}
        }
    }
}
    

#Preview {
    HomeView()
}

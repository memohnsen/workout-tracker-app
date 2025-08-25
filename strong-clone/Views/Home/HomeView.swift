//
//  HomeView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showAlert: Bool = false
    @State private var startEmptyWorkout: Bool = false
    @State private var templateSettings: Bool = false
    
    
    @State private var templates: [String] = ["Template 1", "Template 2", "Template 3", "Template 4"]
    @State private var templateFolder: [String] = ["My Templates"]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()

            ScrollView {
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .trailing) {
                        HStack {
                            Spacer()
                            Button(action: {
                                startEmptyWorkout = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }.sheet(isPresented: $startEmptyWorkout) {
                                VStack(alignment: .center) {
                                    HStack{
                                        Text("New Workout").font(.title).bold()
                                        Spacer()
                                        Image(systemName: "x.circle.fill")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(Color.red)
                                    }
                                    Spacer()
                                }.padding(.top, 24)
                            }
                        }
                    }

                    HStack {
                        Text("Template Workouts").font(.title2)
                        Spacer()
                        
                        Button("+ New Template") {
                            templateFolder.append("New Folder")
                        }.buttonStyle(.borderedProminent)
                    }
                    
                    
                    VStack{
                        HStack {
                            ForEach(templateFolder, id: \.self) {template in
                                Image(systemName: "folder")
                                Text(template)
                                
                                Spacer()
                                
                                Button(action: {
                                    templateSettings = true
                                }) {
                                    Image(systemName: "ellipsis")
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $templateSettings) {
                                    VStack(alignment: .center) {
                                        HStack{
                                            Text("Template Settings").font(.title).bold()
                                            Spacer()
                                            Image(systemName: "x.circle.fill")
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                                .foregroundStyle(Color.red)
                                        }
                                        Spacer()
                                    }.padding(.top, 24)
                                }
                            }
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            
            .alert("Button Clicked", isPresented: $showAlert) {
                Button("Ok") {}
            } message: {Text("Clicked")}
        }
    }
}
    
struct WorkoutCard: View {
    @State private var templateClicked: Bool = false
    
    let title: String
    
    var body: some View {
        
        VStack{
            HStack{
                Text(title).font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                    .imageScale(.small)
            }
            .frame(height: 100)
            .frame(width: 140)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .onTapGesture {
                templateClicked = true
            }
            .sheet(isPresented: $templateClicked) {
                ZStack {
                    Color.gray.opacity(0.1).ignoresSafeArea()
                    
                    VStack(alignment: .center) {
                        HStack{
                            Text(title).font(.title).bold()
                        }
                        Spacer()
                    }.padding(.top, 24)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

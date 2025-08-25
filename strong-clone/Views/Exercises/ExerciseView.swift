//
//  ExerciseView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI

struct ExerciseView: View {
    @State private var searchText: String = ""
    @State private var newExerciseName: String = ""
    @State private var exerciseAddClicked: Bool = false
    @State private var exerciseList: [String] = ["Push-Up", "Squat", "Plank", "Mountain Climbers"]
    
    func addExercise(exercise: String) {
        exerciseList.append(exercise)
    }
    
    var filteredExercises: [String] {
        if searchText.isEmpty {
            return exerciseList
        }
        else {
            return exerciseList.filter {$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                List{
                    if filteredExercises.isEmpty {
                        Button("Create New Exercise") {
                            addExercise(exercise: searchText)
                        }
                    } else {
                        ForEach(filteredExercises, id: \.self) { exercise in
                            HStack{
                                Text(exercise)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .imageScale(.small)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search for an exercise")
                .navigationTitle("Exercise Library")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            exerciseAddClicked = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }.sheet(isPresented: $exerciseAddClicked) {
                VStack(spacing: 20) {
                    Text("Add Exercise").font(.title).bold()
                    
                    TextField("Exercise Name: ", text: $newExerciseName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    HStack {
                        Button("Cancel") {
                            exerciseAddClicked = false
                            newExerciseName = ""
                        }.padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        Button("Add") {
                            let trimmedName = newExerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmedName.isEmpty {
                                addExercise(exercise: trimmedName)
                            }
                            exerciseAddClicked = false
                            newExerciseName = ""
                        }.padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

#Preview {
    ExerciseView()
}

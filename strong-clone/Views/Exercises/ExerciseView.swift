//
//  ExerciseView.swift
//  strong-clone
//
//  Created by Maddisen Mohnsen on 8/24/25.
//

import SwiftUI
import ConvexMobile
internal import Combine

struct Exercises: Decodable {
    let _id: String
    let exercise: String
    let equipment: String
    let muscle_group: String
    let notes: String
    let video_link: String
}

struct ExerciseView: View {
    @State private var searchText: String = ""
    @State private var newExerciseName: String = ""
    @State private var exerciseAddClicked: Bool = false
    @State private var exerciseList: [String] = ["Push-Up", "Squat", "Plank", "Mountain Climbers"]
    
    @State private var exercisesConvex: [Exercises] = []
    
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
    
    //    struct ContentView: View {
    //      @State private var todos: [Todo] = []
    //
    //      var body: some View {
    //        List {
    //          ForEach(todos, id: \._id) { todo in
    //            Text(todo.text)
    //          }
    //        }.task {
    //          for await todos: [Todo] in convex.subscribe(to: "tasks:get")
    //            .replaceError(with: []).values
    //          {
    //            self.todos = todos
    //          }
    //        }.padding()
    //      }
    //    }
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            VStack {
                NavigationStack {
                    List{
                        ForEach(exercisesConvex, id: \._id) { exercise in
                            HStack{
                                Text(exercise.exercise)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .imageScale(.small)
                            }
                        }.task {
                            for await exercises: [Exercises] in convex.subscribe(to: "exercises:get")
                                .replaceError(with: []).values
                            {
                                self.exercisesConvex = exercises
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
}

#Preview {
    ExerciseView()
}

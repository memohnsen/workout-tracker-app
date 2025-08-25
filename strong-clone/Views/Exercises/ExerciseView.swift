import SwiftUI
import ConvexMobile
import Combine

struct Exercises: Decodable, Identifiable {
    let _id: String
    let exercise: String
    let equipment: String
    let muscle_group: String
    let notes: String
    let video_link: String
    
    var id: String { _id }
}

struct ExerciseView: View {
    @State private var searchText: String = ""
    @State private var newExerciseName: String = ""
    @State private var exerciseAddClicked: Bool = false
    @State private var exerciseList: [String] = ["Push-Up", "Squat", "Plank", "Mountain Climbers"]
    
    @State private var exercisesConvex: [Exercises] = []
    @State private var cancellables = Set<AnyCancellable>()
    
    var filteredExercises: [Exercises] {
        if searchText.isEmpty {
            return exercisesConvex
        } else {
            return exercisesConvex.filter {
                $0.exercise.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            VStack {
                NavigationStack {
                    List {
                        ForEach(filteredExercises) { exercise in
                            HStack {
                                Text(exercise.exercise)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .imageScale(.small)
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
                    .onAppear {
                        subscribeToExercises()
                    }
                }
                .sheet(isPresented: $exerciseAddClicked) {
                    VStack(spacing: 20) {
                        Text("Add Exercise").font(.title).bold()
                        
                        TextField("Exercise Name: ", text: $newExerciseName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            Button("Cancel") {
                                exerciseAddClicked = false
                                newExerciseName = ""
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            Button("Add") {
                                let trimmedName = newExerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
                                if !trimmedName.isEmpty {
                                    // TODO: Call Convex mutation here instead of just local append
                                    // e.g. convex.mutation("exercises:add", args: ["exercise": trimmedName])
                                }
                                exerciseAddClicked = false
                                newExerciseName = ""
                            }
                            .padding()
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
    
    private func subscribeToExercises() {
        convex
            .subscribe(to: "exercises:get", yielding: [Exercises].self)
            .replaceError(with: [])
            .sink { exercises in
                self.exercisesConvex = exercises
            }
            .store(in: &cancellables)
    }
}

#Preview{
    ExerciseView()
}

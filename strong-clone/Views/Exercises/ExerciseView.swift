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
    @State private var muscleGroup: String = "Legs"
    @State private var notes: String = ""
    @State private var equipment: String = "Barbell"
    @State private var videoLink: String = ""
        
    @State private var exercisesConvex: [Exercises] = []
    @State private var muscleGroupArray: [String] = [
        "Legs", "Shoulders", "Chest", "Back", "Arms", "Core", "Traps", "Full Body"
    ]
    @State private var equipmentArray: [String] = [
        "Barbell", "Dumbbell", "Kettlebell", "Machine", "Bodyweight"
    ]
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
                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                HStack {
                                    Text(exercise.exercise)
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
                    .onAppear {
                        subscribeToExercises()
                    }
                }
                .sheet(isPresented: $exerciseAddClicked) {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Text("Add Exercise").font(.title).bold()
                        
                        TextField("Exercise Name: ", text: $newExerciseName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Picker("Muscle Group: ", selection: $muscleGroup) {
                            ForEach(muscleGroupArray, id: \.self) { group in
                                Text(group)
                            }
                        }.pickerStyle(.menu)
                            
                        
                        Picker("Muscle Group: ", selection: $equipment) {
                            ForEach(equipmentArray, id: \.self) { group in
                                Text(group)
                            }
                        }.pickerStyle(.menu)
                        
                        TextField("Video Link: ", text: $videoLink)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        TextField("Exercise Notes: ", text: $notes)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Spacer()
                        
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
                                    Task {
                                        do {
                                            try await convex.mutation("exercises:add", with: [
                                                "exercise": trimmedName,
                                                "equipment": equipment,
                                                "muscle_group": muscleGroup,
                                                "notes": notes,
                                                "video_link": videoLink
                                            ])
                                        } catch {
                                            print(error)
                                        }
                                    }
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
                        Spacer()
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

struct ExerciseDetailView: View {
    let exercise: Exercises
    
    var body: some View {
        
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    HStack {
                        Text("Video Link:")
                        Text(exercise.video_link)
                    }
                    Spacer()
                    HStack {
                        Text("Muscle Group:")
                        Text(exercise.muscle_group)
                    }
                    HStack {
                        Text("Equipment:")
                        Text(exercise.equipment)
                    }

                    HStack {
                        Text("Exercise Notes:")
                        Text(exercise.notes)
                    }
                    Spacer()
                }
            }
            .navigationTitle(exercise.exercise)
            .navigationBarTitleDisplayMode(.inline)
            

        }
    }
}

#Preview{
    ExerciseView()
}

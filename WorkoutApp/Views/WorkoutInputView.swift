import SwiftUI

struct WorkoutInputView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    @State private var selectedMuscles: [String] = []
    @State private var selectedEquipment: [String] = []
    @State private var selectedPatterns: [String] = []
    @State private var selectedIntensity: String = "Medium"
    @State private var selectedDifficulty: Int = 3
    @State private var selectedDuration: Int = 30

    @State private var showGeneratedWorkout = false

    let allMuscles = ["Chest", "Back", "Arms", "Shoulders", "Legs", "Abs", "Full Body"]
    let allEquipment = ["Body Weight", "Dumbbells", "Barbell", "Kettlebell", "Machine", "Cable", "Band"]
    let allPatterns = ["Push", "Pull", "Compound", "Isolation", "Core", "Cardio"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("🎯 Workout Builder")
                        .font(.title2)
                        .bold()

                    Group {
                        Text("Target Muscles")
                        WrapSelector(options: allMuscles, selection: $selectedMuscles)
                    }

                    Group {
                        Text("Equipment")
                        WrapSelector(options: allEquipment, selection: $selectedEquipment)
                    }

                    Group {
                        Text("Movement Patterns")
                        WrapSelector(options: allPatterns, selection: $selectedPatterns)
                    }

                    Group {
                        Text("Intensity")
                        Picker("Intensity", selection: $selectedIntensity) {
                            Text("Low").tag("Low")
                            Text("Medium").tag("Medium")
                            Text("High").tag("High")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Group {
                        Text("Difficulty Level: \(selectedDifficulty)")
                        Slider(value: Binding(
                            get: { Double(selectedDifficulty) },
                            set: { selectedDifficulty = Int($0) }
                        ), in: 1...5, step: 1)
                    }

                    Group {
                        Text("Workout Duration (minutes): \(selectedDuration)")
                        Slider(value: Binding(
                            get: { Double(selectedDuration) },
                            set: { selectedDuration = Int($0) }
                        ), in: 10...90, step: 5)
                    }

                    Button(action: {
                        viewModel.generateWorkout(
                            duration: selectedDuration,
                            intensity: selectedIntensity,
                            muscleGroups: selectedMuscles,
                            equipment: selectedEquipment
                        )
                        showGeneratedWorkout = true
                    }) {
                        Text("🚀 Generate Workout")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
                .navigationTitle("Generate")
                .sheet(isPresented: $showGeneratedWorkout) {
                    WorkoutView(viewModel: viewModel, allExercises: viewModel.allExercises)
                }
            }
        }
    }
}

import SwiftUI

struct SavedWorkoutsView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.savedWorkouts.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Text("No saved workouts yet.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Generate a workout and tap Save to keep it here.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                } else {
                    List {
                        ForEach(Array(viewModel.savedWorkouts.enumerated()), id: \.offset) { (index, workout) in
                            Section(header: Text("Workout #\(index + 1)")) {
                                ForEach(workout) { we in
                                    VStack(alignment: .leading) {
                                        Text(we.exercise.name)
                                            .font(.headline)
                                        Text("\(we.sets) sets x \(we.reps) reps")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }

                                NavigationLink {
                                    WorkoutSessionView(viewModel: WorkoutViewModelMock(workout: workout))
                                } label: {
                                    Text("Start This Workout")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }

                if !viewModel.savedWorkouts.isEmpty {
                    Button("Delete All Saved Workouts") {
                        viewModel.deleteAllSavedWorkouts()
                    }
                    .foregroundColor(.red)
                    .padding(.top)
                }
            }
            .navigationTitle("Saved Workouts")
        }
    }
}

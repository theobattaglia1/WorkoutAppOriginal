import SwiftUI

struct WorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    let allExercises: [Exercise]

    var body: some View {
        VStack {
            List(viewModel.workout) { we in
                VStack(alignment: .leading, spacing: 4) {
                    Text(we.exercise.name)
                        .font(.headline)
                    Text("\(we.sets) sets x \(we.reps) reps")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Button("Save Workout") {
                viewModel.saveCurrentWorkout() // ✅ FIXED NAME
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle("Your Workout")
    }
}


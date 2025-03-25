import SwiftUI

struct WorkoutExerciseRow: View {
    let exercise: WorkoutExercise
    let allExercises: [Exercise]
    let onSwap: (WorkoutExercise) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(exercise.exercise.name)
                    .font(.headline)

                Spacer()

                Button(action: {
                    onSwap(exercise)
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
                .help("Swap this exercise")
            }

            Text("\(exercise.sets) sets x \(exercise.reps) reps")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("Equipment: \(exercise.exercise.equipment)")
                .font(.footnote)
                .foregroundColor(.gray)

            if let gifUrl = exercise.exercise.gifUrl, let url = URL(string: gifUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
            }
        }
        .padding(.vertical, 8)
    }
}

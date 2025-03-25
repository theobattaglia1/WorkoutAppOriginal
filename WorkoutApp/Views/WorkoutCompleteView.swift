
import SwiftUI

struct WorkoutCompleteView: View {
    let duration: Int
    let workout: [WorkoutExercise]

    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 Workout Complete!")
                .font(.largeTitle)
                .bold()

            Text("Duration: \(duration) minutes")
                .font(.headline)

            Divider()

            List(workout) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Sets: \(exercise.sets)   Reps: \(exercise.reps)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }

            Spacer()

            Button(action: {
                // Navigation or data save hook
            }) {
                Text("🏠 Return to Week Plan")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top)
        }
        .padding()
    }
}

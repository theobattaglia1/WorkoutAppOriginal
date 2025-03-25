
import SwiftUI

struct WorkoutSessionLauncher: View {
    let day: WorkoutDay
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationLink(destination: WorkoutSessionView(viewModel: viewModel)) {
            VStack(alignment: .leading, spacing: 12) {
                Text(day.day)
                    .font(.headline)
                Text(day.focus)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Exercises: \(day.exercises.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.gray)))
        }
        .simultaneousGesture(TapGesture().onEnded {
            viewModel.workout = day.exercises
        })
    }
}

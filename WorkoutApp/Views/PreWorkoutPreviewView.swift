import SwiftUI

struct PreWorkoutPreviewView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("🔥 \(sessionTitle)")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 12) {
                    Label("Duration: \(totalDuration) min", systemImage: "clock")
                    Label("Intensity: \(intensity)", systemImage: "flame")
                    Label("Muscles: \(muscleGroups)", systemImage: "figure.strengthtraining.traditional")
                }
                .font(.subheadline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 16) {
                    phaseRow(title: "Warm-Up", count: 3, duration: 5)
                    phaseRow(title: "Main", count: 4, duration: 25)
                    phaseRow(title: "Accessory", count: 3, duration: 10)
                    phaseRow(title: "Finisher", count: 2, duration: 5)
                }
                .padding(.horizontal)

                Spacer()

                NavigationLink(value: "startSession") {
                    Text("🚀 Start Workout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationTitle("Workout Overview")
            .navigationDestination(for: String.self) { route in
                if route == "startSession" {
                    WorkoutSessionView(viewModel: viewModel)
                }
            }
        }
    }

    private func phaseRow(title: String, count: Int, duration: Int) -> some View {
        HStack {
            Text("\(title):").bold()
            Spacer()
            Text("\(count) exercises • \(duration) min")
        }
        .font(.subheadline)
    }

    private var sessionTitle: String {
        let bodyParts = viewModel.workout.map { $0.exercise.bodyPart }
        let main = Set(bodyParts).joined(separator: ", ")
        return main.isEmpty ? "Custom Workout" : "\(main) Session"
    }

    private var totalDuration: Int {
        45
    }

    private var intensity: String {
        viewModel.workout.first?.exercise.intensity ?? "Medium"
    }

    private var muscleGroups: String {
        let muscles = viewModel.workout.flatMap { $0.exercise.muscleGroups }
        return Set(muscles).sorted().joined(separator: ", ")
    }
}

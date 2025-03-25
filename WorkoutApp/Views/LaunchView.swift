import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var isReady: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                Text("🏋️‍♂️ Workout Builder")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Generate smart workouts based on your goals using AI.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                if !viewModel.allExercises.isEmpty {
                    ProgressView("Preparing your experience...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                }

                Spacer()

                if isReady {
                    NavigationLink {
                        MainTabView(allExercises: viewModel.allExercises, viewModel: viewModel)
                    } label: {
                        Text("Continue")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .onAppear {
                loadData()
            }
        }
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "AllExercises", withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            print("❌ Failed to load AllExercises.json")
            return
        }

        viewModel.loadAllExercises(from: data)
        viewModel.loadSavedWorkouts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            isReady = true
        }
    }
}

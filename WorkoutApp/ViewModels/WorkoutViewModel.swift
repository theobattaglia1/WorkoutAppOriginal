import Foundation
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var allExercises: [Exercise] = []
    @Published var workout: [WorkoutExercise] = []
    @Published var savedWorkouts: [[WorkoutExercise]] = []

    @Published var swapTarget: WorkoutExercise?
    @Published var availableReplacements: [Exercise] = []

    private let storage = WorkoutStorageService.shared
    private let api = OpenAIService(apiKey: Bundle.main.openAIAPIKey ?? "")

    // MARK: - Load from Exercise DB JSON
    func loadAllExercises(from jsonData: Data) {
        let decoded = ExerciseDBService.parseExercises(from: jsonData)
        self.allExercises = decoded
    }

    // MARK: - Load Saved
    func loadSavedWorkouts() {
        savedWorkouts = storage.load()
    }

    // MARK: - Save Current Workout
    func saveCurrentWorkout() {
        guard !workout.isEmpty else { return }
        savedWorkouts.append(workout)
        storage.save(workouts: savedWorkouts)
    }

    func deleteAllSavedWorkouts() {
        savedWorkouts.removeAll()
        storage.deleteAll()
    }

    // MARK: - GPT Workout Generator
    func generateWorkout(duration: Int, intensity: String, muscleGroups: [String], equipment: [String]) {
        api.generateWorkoutPlan(
            from: allExercises,
            duration: duration,
            intensity: intensity,
            muscles: muscleGroups,
            equipment: equipment
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let generated):
                    self.workout = generated
                case .failure(let error):
                    print("❌ Failed to generate workout: \(error)")
                }
            }
        }
    }

    // MARK: - Swap Support
    func prepareSwap(for current: WorkoutExercise, from all: [Exercise]) {
        swapTarget = current

        availableReplacements = all.filter {
            normalize($0.bodyPart) == normalize(current.exercise.bodyPart) &&
            normalize($0.equipment) == normalize(current.exercise.equipment)
        }

        print("🔄 Found \(availableReplacements.count) replacement options.")
    }

    func performSwap(with newExercise: Exercise) {
        guard let index = workout.firstIndex(where: { $0.id == swapTarget?.id }) else { return }

        workout[index] = WorkoutExercise(
            id: UUID(),
            exercise: newExercise,
            sets: newExercise.recommendedSets,
            reps: newExercise.recommendedReps
        )

        swapTarget = nil
        availableReplacements = []
    }

    private func normalize(_ text: String) -> String {
        text
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

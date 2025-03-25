import Foundation
import SwiftUI

class WorkoutSessionViewModel: ObservableObject {
    @Published var currentPhase: WorkoutPhase = .warmUp
    @Published var currentIndex: Int = 0
    @Published var isWorkoutComplete: Bool = false
    @Published var progress: Double = 0.0
    @Published var setWeights: [Double]
    @Published var completedSets: Set<Int> = []

    private(set) var exercises: [WorkoutExercise] = []
    let restDuration = 45

    init(exercises: [WorkoutExercise]) {
        self.exercises = exercises
        self.setWeights = Array(repeating: 0.0, count: 10)
        updateProgress()
    }

    var totalExercises: Int {
        exercises.count
    }

    var currentExercise: WorkoutExercise {
        exercises[currentIndex]
    }

    var currentPhaseDisplay: String {
        currentPhase.rawValue
    }

    var shouldShowRest: Bool {
        !isWorkoutComplete && completedSets.count == currentExercise.sets
    }

    var canContinue: Bool {
        completedSets.count == currentExercise.sets && !isWorkoutComplete
    }

    func toggleSetCompletion(setIndex: Int) {
        if completedSets.contains(setIndex) {
            completedSets.remove(setIndex)
        } else {
            completedSets.insert(setIndex)
        }
    }

    func isSetCompleted(_ index: Int) -> Bool {
        completedSets.contains(index)
    }

    func startRest() {
        completedSets.removeAll()
    }

    func goToNextExercise() {
        completedSets.removeAll()
        if currentIndex < exercises.count - 1 {
            currentIndex += 1
            updateProgress()
        } else {
            isWorkoutComplete = true
            progress = 1.0
        }
    }

    func reloadCurrentExercise(from workout: [WorkoutExercise]) {
        if currentIndex < workout.count {
            self.exercises = workout
        }
    }

    func pauseSession() {
        // Optional pause logic
    }

    private func updateProgress() {
        let percent = Double(currentIndex) / Double(max(1, totalExercises))
        progress = min(percent, 1.0)
    }
}

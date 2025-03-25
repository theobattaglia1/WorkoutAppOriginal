//
//  WorkoutViewModel.swift
//  GPTWorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//


import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var workout: [WorkoutExercise] = []
    @Published var currentPhaseIndex: Int = 0
    @Published var completedExercises: Set<UUID> = []

    var currentExercise: WorkoutExercise? {
        guard currentPhaseIndex < workout.count else { return nil }
        return workout[currentPhaseIndex]
    }

    func markExerciseComplete(_ exercise: WorkoutExercise) {
        completedExercises.insert(exercise.id)
    }

    func goToNextExercise() {
        if currentPhaseIndex + 1 < workout.count {
            currentPhaseIndex += 1
        }
    }

    func resetWorkout() {
        workout = []
        currentPhaseIndex = 0
        completedExercises.removeAll()
    }

    var isWorkoutComplete: Bool {
        return completedExercises.count == workout.count
    }
}

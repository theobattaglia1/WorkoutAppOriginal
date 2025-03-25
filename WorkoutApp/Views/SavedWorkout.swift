//
//  SavedWorkout.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

import Foundation

struct SavedWorkout: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let createdAt: Date
    let exercises: [WorkoutExercise]
}

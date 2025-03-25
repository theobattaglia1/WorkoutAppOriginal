//
//  WorkoutDay.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//



import Foundation

struct WorkoutDay: Codable {
    let day: String
    let focus: String
    let exercises: [WorkoutExercise]
}

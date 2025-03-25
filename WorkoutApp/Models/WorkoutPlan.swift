//
//  WorkoutPlan.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//



import Foundation

struct WorkoutPlan: Codable {
    let title: String
    let duration: Int
    let week_plan: [WorkoutDay]
}

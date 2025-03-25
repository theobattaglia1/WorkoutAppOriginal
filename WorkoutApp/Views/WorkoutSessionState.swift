//
//  WorkoutSessionState.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

enum WorkoutSessionState: String, CaseIterable, Codable {
    case notStarted
    case active
    case paused
    case resting
    case completed
}

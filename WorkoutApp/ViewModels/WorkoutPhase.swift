//
//  WorkoutPhase.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

enum WorkoutPhase: String, CaseIterable, Codable {
    case warmUp = "Warm-Up"
    case main = "Main"
    case accessory = "Accessory"
    case finisher = "Finisher"
}


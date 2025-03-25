//
//  WgerLookup.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


struct WgerLookup {
    static func equipmentName(for id: Int) -> String {
        switch id {
            case 1: return "Barbell"
            case 2: return "SZ-Bar"
            case 3: return "Dumbbell"
            case 4: return "Gym mat"
            case 5: return "Swiss Ball"
            case 6: return "Pull-up bar"
            case 7: return "None"
            case 8: return "Bench"
            case 9: return "Incline bench"
            case 10: return "Kettlebell"
            default: return "Unknown"
        }
    }

    static func muscleName(for id: Int) -> String {
        switch id {
            case 1: return "Biceps"
            case 2: return "Shoulders"
            case 3: return "Chest"
            case 4: return "Triceps"
            case 5: return "Abs"
            case 6: return "Calves"
            case 7: return "Quads"
            case 8: return "Hamstrings"
            case 9: return "Glutes"
            case 10: return "Back"
            default: return "General"
        }
    }

    static func categoryName(for id: Int?) -> String {
        switch id {
            case 10: return "Abs"
            case 8: return "Arms"
            case 12: return "Back"
            case 14: return "Calves"
            case 11: return "Chest"
            case 9: return "Legs"
            case 13: return "Shoulders"
            case 15: return "Glutes"
            default: return "General"
        }
    }
}

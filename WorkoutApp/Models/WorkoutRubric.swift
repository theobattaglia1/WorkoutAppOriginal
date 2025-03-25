import Foundation

struct WorkoutRubric: Codable {
    let targetMuscles: [String]
    let preferredEquipment: [String]
    let movementPatterns: [String]
    let intensity: String
    let difficulty: Int
}

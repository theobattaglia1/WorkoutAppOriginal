
import Foundation

struct WorkoutExercise: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let sets: Int
    let reps: String
    let rest: String?
    let recommended_load: String?
    let structure: String? // e.g. Superset, Circuit, Finisher
}

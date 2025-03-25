
import Foundation

public struct WorkoutExercise: Identifiable, Codable, Hashable {
    public var id = UUID()
    public let name: String
    public let sets: Int
    public let reps: String
    public let rest: String?
    public let recommended_load: String?
    public let structure: String?
}

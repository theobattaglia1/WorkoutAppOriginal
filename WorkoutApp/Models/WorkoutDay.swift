
import Foundation

public struct WorkoutDay: Codable, Hashable {
    public let day: String
    public let focus: String
    public let exercises: [WorkoutExercise]
}

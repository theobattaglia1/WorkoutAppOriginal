
import Foundation

public struct WorkoutPlan: Codable, Hashable {
    public let title: String
    public let week_plan: [WorkoutDay]
}

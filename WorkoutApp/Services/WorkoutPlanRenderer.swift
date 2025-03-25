
import Foundation

public struct WorkoutPlanRenderer {
    public static func renderDailyPlan(for day: WorkoutDay) -> [WorkoutExercise] {
        return day.exercises
    }

    public static func renderFullWeek(plan: WorkoutPlan) -> [WorkoutDay] {
        return plan.week_plan
    }
}

//
//  WorkoutPlanRenderer.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//



import Foundation

struct WorkoutPlanRenderer {
    static func renderDailyPlan(for day: WorkoutDay) -> [WorkoutExercise] {
        return day.exercises
    }

    static func renderFullWeek(plan: WorkoutPlan) -> [WorkoutDay] {
        return plan.week_plan
    }
}

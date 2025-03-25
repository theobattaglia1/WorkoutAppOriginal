//
//  RubricPromptBuilder.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//



import Foundation

struct RubricPromptBuilder {
    static func buildPrompt(goal: String, duration: Int, frequency: Int, experienceLevel: String, focusAreas: [String]) -> String {
        let focusList = focusAreas.joined(separator: ", ")
        return """
You are a world-class training architect AI.

Your job is to create a complete, scientifically grounded workout plan for a user based on the following parameters:

Goal: \(goal)
Workout Length: \(duration) minutes
Weekly Frequency: \(frequency) days/week
Experience Level: \(experienceLevel)
Target Muscle Groups: \(focusList)

Design a plan that:
- Reflects periodization, overload, and recovery principles
- Uses supersets and compound lifts where applicable
- Aligns each workout with overall goals
- Includes strength, hypertrophy, conditioning, and recovery sessions

Return the plan as structured JSON in the format:
{
  "title": "...",
  "duration": 45,
  "week_plan": [
    {
      "day": "Day 1",
      "focus": "...",
      "exercises": [
        {
          "name": "...",
          "sets": 3,
          "reps": "8-10",
          "rest": "60s",
          "recommended_load": "70-80% 1RM",
          "structure": "Straight" // Optional: Superset, Finisher, Circuit
        }
      ]
    }
  ]
}
Only output valid JSON. Do not include commentary.
"""
    }
}

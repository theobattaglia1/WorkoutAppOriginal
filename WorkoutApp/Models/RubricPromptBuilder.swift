
import Foundation

public struct RubricPromptBuilder {
    public static func buildPrompt(goal: String, duration: Int, frequency: Int, experienceLevel: String, focusAreas: [String]) -> String {
        return """
        You are a professional fitness coach. Design a 7-day workout plan using JSON structure. Make it focused on: \(goal)
        - Duration: \(duration) minutes
        - Frequency: \(frequency) days/week
        - Experience: \(experienceLevel)
        - Target Areas: \(focusAreas.joined(separator: ", "))

        Return ONLY valid JSON in this format:
        {
          "title": "Plan Title",
          "week_plan": [
            {
              "day": "Day 1",
              "focus": "Upper Body Strength",
              "exercises": [
                {
                  "name": "Barbell Bench Press",
                  "sets": 4,
                  "reps": "6-8",
                  "rest": "60s",
                  "recommended_load": "75% 1RM",
                  "structure": "Straight Sets"
                }
              ]
            }
          ]
        }
        """
    }
}

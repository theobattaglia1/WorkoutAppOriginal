import Foundation

class RubricPromptBuilder {
    static func buildPrompt(duration: Int,
                            intensity: String,
                            muscleGroups: [String],
                            equipment: [String]) -> String {

        return """
        You are a professional fitness assistant. The user will give you workout preferences. You must return ONLY the following JSON object structure — and nothing else.

        User Preferences:
        - Duration: \(duration) minutes
        - Intensity: \(intensity)
        - Target Muscle Groups: \(muscleGroups.joined(separator: ", "))
        - Available Equipment: \(equipment.joined(separator: ", "))

        ONLY return a JSON response like this:

        {
          "targetMuscles": [String],
          "preferredEquipment": [String],
          "movementPatterns": [String],
          "intensity": String,
          "difficulty": Int
        }

        Do not add extra fields like workoutDuration. Do not include markdown or explanations. Return only the raw JSON block.
        """
    }
}

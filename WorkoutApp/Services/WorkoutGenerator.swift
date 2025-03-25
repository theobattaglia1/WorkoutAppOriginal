import Foundation

class WorkoutGenerator {
    static func generateWorkout(from allExercises: [Exercise], using rubric: WorkoutRubric) -> [WorkoutExercise] {
        print("""
        📊 GPT Workout Rubric Received:
        - Muscles: \(rubric.targetMuscles)
        - Equipment: \(rubric.preferredEquipment)
        - Movement Patterns: \(rubric.movementPatterns)
        - Intensity: \(rubric.intensity)
        - Difficulty: \(rubric.difficulty)
        """)
        
        print("🧠 First 5 Exercises Loaded:")
        for e in allExercises.prefix(5) {
            print("- \(e.name) | muscles: \(e.muscleGroups) | equipment: \(e.equipment)")
        }

        let normalizedPatterns = rubric.movementPatterns.map { normalize($0, from: fuzzyMovementMap) }
        let normalizedEquipment = rubric.preferredEquipment.map { normalize($0, from: fuzzyEquipmentMap) }
        let normalizedTargetMuscles = rubric.targetMuscles.map { $0.lowercased() }

        let filtered = allExercises.filter { ex in
            let exerciseMuscles = Set(ex.muscleGroups.map { $0.lowercased() })
            let targetMuscles = Set(normalizedTargetMuscles)
            let matchesMuscles = targetMuscles.isEmpty || !exerciseMuscles.isDisjoint(with: targetMuscles)


            let matchesEquipment = normalizedEquipment.isEmpty || normalizedEquipment.contains {
                $0.caseInsensitiveCompare(ex.equipment) == .orderedSame
            }

            let matchesMovement = normalizedPatterns.isEmpty || normalizedPatterns.contains {
                $0.caseInsensitiveCompare(ex.movementPattern) == .orderedSame
            }

            let matchesIntensity = ex.intensity.caseInsensitiveCompare(rubric.intensity) == .orderedSame
            let matchesDifficulty = ex.difficulty <= rubric.difficulty

            return matchesMuscles && matchesEquipment && matchesMovement && matchesIntensity && matchesDifficulty
        }

        print("✅ Filtered \(filtered.count) matching exercises using robust fuzzy logic")

        let selected = Array(filtered.prefix(6))

        return selected.map {
            WorkoutExercise(
                id: UUID(),
                exercise: $0,
                sets: $0.recommendedSets,
                reps: $0.recommendedReps
            )
        }
    }

    // MARK: - Fuzzy Synonym Maps

    private static let fuzzyMovementMap: [String: [String]] = [
        "Push": ["push", "pushing", "press", "pressing", "push-focused"],
        "Pull": ["pull", "pulling", "row", "rowing", "pull-focused"],
        "Compound": ["compound", "multi-joint", "full-body", "integrated"],
        "Isolation": ["isolation", "isolated", "single-joint", "targeted"],
        "Core": ["core", "ab", "abs", "trunk", "midsection"],
        "Cardio": ["cardio", "aerobic", "conditioning", "heart rate", "metcon"]
    ]

    private static let fuzzyEquipmentMap: [String: [String]] = [
        "Dumbbell": ["dumbbell", "dumbbells", "db"],
        "Barbell": ["barbell", "bb"],
        "Body Weight": ["bodyweight", "body weight", "bw", "no equipment"],
        "Band": ["band", "resistance band", "loop band", "elastic"],
        "Kettlebell": ["kettlebell", "kb"],
        "Machine": ["machine", "weight machine", "cable machine"],
        "Cable": ["cable", "cable machine", "pulley"],
        "Bench": ["bench", "workout bench", "flat bench", "adjustable bench"]
    ]

    // MARK: - Fuzzy Normalizer

    private static func normalize(_ input: String, from map: [String: [String]]) -> String {
        let lower = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        for (key, aliases) in map {
            if aliases.contains(where: { lower.contains($0) }) {
                return key
            }
        }

        return input.capitalized
    }
}

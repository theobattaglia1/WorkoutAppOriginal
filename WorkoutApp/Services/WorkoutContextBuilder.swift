import Foundation

class WorkoutContextBuilder {
    static func buildContext(
        from all: [Exercise],
        targetMuscles: [String],
        equipment: [String],
        movementPatterns: [String] = []
    ) -> [Exercise] {

        let filtered = all.filter { ex in
            let matchesMuscles = targetMuscles.isEmpty || ex.muscleGroups.contains(where: { m in
                targetMuscles.contains { normalize($0) == normalize(m) }
            })

            let matchesEquipment = equipment.isEmpty || equipment.contains(where: {
                normalize($0) == normalize(ex.equipment)
            })

            let matchesPattern = movementPatterns.isEmpty || movementPatterns.contains(where: {
                normalize($0) == normalize(ex.movementPattern)
            })

            return matchesMuscles && matchesEquipment && matchesPattern
        }

        if filtered.isEmpty {
            print("⚠️ No matching exercises found. Falling back to first 5.")
            return Array(all.prefix(5))
        }

        print("✅ Filtered \(filtered.count) matching exercises using robust fuzzy logic")
        return filtered
    }

    // MARK: - Fuzzy Normalizer
    static func normalize(_ text: String) -> String {
        return text
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "dumbbells", with: "dumbbell")
            .replacingOccurrences(of: "legs", with: "quads")
            .replacingOccurrences(of: "glutes", with: "gluteus")
            .replacingOccurrences(of: "pulling", with: "pull")
            .replacingOccurrences(of: "pushing", with: "push")
            .replacingOccurrences(of: "arms", with: "biceps")
            .replacingOccurrences(of: "shoulder", with: "shoulders")
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "_", with: " ")
            .folding(options: .diacriticInsensitive, locale: .current)
    }
}

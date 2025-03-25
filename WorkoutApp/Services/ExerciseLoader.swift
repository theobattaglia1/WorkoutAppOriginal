import Foundation

class ExerciseLoader {
    static func loadExercises() -> [Exercise] {
        guard let url = Bundle.main.url(forResource: "AllExercises", withExtension: "json") else {
            print("❌ Failed to find AllExercises.json in bundle.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Exercise].self, from: data)
            print("✅ Loaded \(decoded.count) bundled exercises from AllExercises.json")
            return decoded
        } catch {
            print("❌ Failed to decode AllExercises.json: \(error)")
            return []
        }
    }
}


import Foundation

struct ExerciseMedia: Codable {
    let name: String
    let gifUrl: String?
    let instructions: [String]
    let bodyPart: String
    let equipment: String
}

class ExerciseDBService {
    private var allExercises: [ExerciseMedia] = []

    init() {
        loadExercises()
    }

    private func loadExercises() {
        guard let url = Bundle.main.url(forResource: "AllExercises", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Could not load AllExercises.json")
            return
        }

        do {
            let decoder = JSONDecoder()
            self.allExercises = try decoder.decode([ExerciseMedia].self, from: data)
            print("✅ Loaded \(allExercises.count) media exercises.")
        } catch {
            print("❌ Failed to decode AllExercises.json: \(error)")
        }
    }

    func media(for exerciseName: String) -> ExerciseMedia? {
        return allExercises.first { $0.name.lowercased() == exerciseName.lowercased() }
    }
}

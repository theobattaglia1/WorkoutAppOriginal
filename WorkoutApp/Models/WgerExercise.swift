import Foundation

struct WgerExerciseResponse: Codable {
    let results: [WgerExercise]
}

struct WgerExercise: Codable {
    let id: Int
    let category: WgerCategory?
    let muscles: [WgerMuscle]
    let equipment: [WgerEquipment]
    let translations: [Translation]

    struct WgerCategory: Codable {
        let id: Int
        let name: String
    }

    struct WgerMuscle: Codable {
        let id: Int
        let name: String
    }

    struct WgerEquipment: Codable {
        let id: Int
        let name: String
    }

    struct Translation: Codable {
        let language: Int
        let name: String
        let description: String
    }

    func toExercise(using matcher: GIFMatcher? = nil) -> Exercise {
        // Prefer English translation
        let english = translations.first(where: { $0.language == 2 })
        let name = english?.name ?? "Unnamed"
        let description = english?.description.htmlToText ?? "No description"

        let bodyPart = category?.name ?? "General"
        let equipmentName = equipment.map { $0.name }.joined(separator: ", ")
        let gif = matcher?.findGIF(for: name)
        let muscleNames = muscles.map { $0.name }

        return Exercise(
            id: UUID(),
            name: name,
            bodyPart: bodyPart,
            difficulty: 3,
            intensity: "Medium",
            movementPattern: "Compound",
            equipment: equipmentName,
            recommendedReps: "10–12",
            recommendedSets: 3,
            gifUrl: gif,
            description: description,
            muscleGroups: muscleNames
        )
    }
}

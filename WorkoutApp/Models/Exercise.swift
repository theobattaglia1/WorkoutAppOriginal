import Foundation

struct Exercise: Identifiable, Hashable {
    let id: UUID
    let name: String
    let bodyPart: String
    let difficulty: Int
    let intensity: String
    let movementPattern: String
    let equipment: String
    let recommendedReps: String
    let recommendedSets: Int
    let gifUrl: String?
    let description: String
    let muscleGroups: [String]
}

// MARK: - Codable conformance
extension Exercise: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, bodyPart, category, difficulty, intensity,
             movementPattern, equipment, recommendedReps, recommendedSets,
             gifUrl, description, muscleGroups
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        name = try c.decode(String.self, forKey: .name)
        bodyPart = try (try? c.decode(String.self, forKey: .bodyPart)) ?? c.decode(String.self, forKey: .category)
        difficulty = try c.decode(Int.self, forKey: .difficulty)
        intensity = try c.decode(String.self, forKey: .intensity)
        movementPattern = try c.decode(String.self, forKey: .movementPattern)
        equipment = try c.decode(String.self, forKey: .equipment)
        recommendedReps = try c.decode(String.self, forKey: .recommendedReps)
        recommendedSets = try c.decode(Int.self, forKey: .recommendedSets)
        gifUrl = try c.decodeIfPresent(String.self, forKey: .gifUrl)
        description = try c.decode(String.self, forKey: .description)
        muscleGroups = try c.decode([String].self, forKey: .muscleGroups)
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(name, forKey: .name)
        try c.encode(bodyPart, forKey: .bodyPart)
        try c.encode(difficulty, forKey: .difficulty)
        try c.encode(intensity, forKey: .intensity)
        try c.encode(movementPattern, forKey: .movementPattern)
        try c.encode(equipment, forKey: .equipment)
        try c.encode(recommendedReps, forKey: .recommendedReps)
        try c.encode(recommendedSets, forKey: .recommendedSets)
        try c.encodeIfPresent(gifUrl, forKey: .gifUrl)
        try c.encode(description, forKey: .description)
        try c.encode(muscleGroups, forKey: .muscleGroups)
    }
}

// MARK: - Placeholder
extension Exercise {
    static func placeholder() -> Exercise {
        Exercise(
            id: UUID(),
            name: "Placeholder",
            bodyPart: "Full Body",
            difficulty: 1,
            intensity: "Medium",
            movementPattern: "Compound",
            equipment: "Body Weight",
            recommendedReps: "10–12",
            recommendedSets: 3,
            gifUrl: nil,
            description: "No data available.",
            muscleGroups: ["Full Body"]
        )
    }
}

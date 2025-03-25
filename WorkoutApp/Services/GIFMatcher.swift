//
//  GIFMatcher.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

class GIFMatcher {
    private var gifLookup: [String: String] = [:]

    init() {
        loadGIFLookup()
    }

    private func loadGIFLookup() {
        let url = ExerciseDBDownloader.cacheURL() // 🔧 use the correct path

        guard let data = try? Data(contentsOf: url) else {
            print("❌ Could not load ExerciseDB.json")
            return
        }

        do {
            let decoded = try JSONDecoder().decode([ExerciseDBEntry].self, from: data)
            for entry in decoded {
                let normalized = normalize(entry.name)
                gifLookup[normalized] = entry.gifUrl
            }
            print("🎥 Loaded \(gifLookup.count) GIF entries.")
        } catch {
            print("❌ Failed to decode ExerciseDB JSON: \(error)")
        }
    }


    private func normalize(_ text: String) -> String {
        return text
            .lowercased()
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func findGIF(for exerciseName: String) -> String? {
        let key = normalize(exerciseName)
        return gifLookup[key]
    }
}

struct ExerciseDBEntry: Codable {
    let id: String
    let name: String
    let bodyPart: String
    let equipment: String
    let gifUrl: String
}


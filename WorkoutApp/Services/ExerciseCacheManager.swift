//
//  ExerciseCacheManager.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

class ExerciseCacheManager {
    private static let fileName = "cached_exercises.json"

    private static var cacheURL: URL {
        let manager = FileManager.default
        let dir = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }

    // MARK: - Save
    static func save(_ exercises: [Exercise]) {
        do {
            let data = try JSONEncoder().encode(exercises)
            try data.write(to: cacheURL)
            print("💾 Exercises cached successfully.")
        } catch {
            print("❌ Failed to cache exercises: \(error)")
        }
    }

    // MARK: - Load
    static func load() -> [Exercise] {
        do {
            let data = try Data(contentsOf: cacheURL)
            let decoded = try JSONDecoder().decode([Exercise].self, from: data)
            print("📦 Loaded \(decoded.count) exercises from cache.")
            return decoded
        } catch {
            print("⚠️ No cached exercises found or failed to decode: \(error)")
            return []
        }
    }

    // Optional: clear cache
    static func clear() {
        try? FileManager.default.removeItem(at: cacheURL)
        print("🧹 Cleared cached exercises.")
    }
}

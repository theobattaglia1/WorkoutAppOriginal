//
//  WorkoutStorageService.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/23/25.
//


import Foundation

class WorkoutStorageService {
    static let shared = WorkoutStorageService()

    private let fileName = "saved_workouts.json"

    private var fileURL: URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(fileName)
    }

    func save(workouts: [[WorkoutExercise]]) {
        do {
            let data = try JSONEncoder().encode(workouts)
            try data.write(to: fileURL)
            print("✅ Workouts saved successfully.")
        } catch {
            print("❌ Failed to save workouts: \(error)")
        }
    }

    func load() -> [[WorkoutExercise]] {
        do {
            let data = try Data(contentsOf: fileURL)
            let workouts = try JSONDecoder().decode([[WorkoutExercise]].self, from: data)
            print("✅ Loaded \(workouts.count) saved workouts.")
            return workouts
        } catch {
            print("⚠️ No saved workouts found or decode failed: \(error)")
            return []
        }
    }

    func deleteAll() {
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("🗑️ All workouts deleted.")
        } catch {
            print("⚠️ Could not delete workouts: \(error)")
        }
    }
}

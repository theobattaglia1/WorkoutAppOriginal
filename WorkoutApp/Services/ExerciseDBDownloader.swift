//
//  ExerciseDBDownloader.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

class ExerciseDBDownloader {
    private static let endpoint = "https://exercisedb.p.rapidapi.com/exercises"
    private static let apiKey = "fd0263798dmsh9528d12a417cb55p11da14jsn050e347d51e5" // ✅ your real key
    private static let host = "exercisedb.p.rapidapi.com"

    static func fetchAndCacheExerciseDB() {
        guard let url = URL(string: endpoint) else {
            print("❌ Invalid ExerciseDB URL.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue(host, forHTTPHeaderField: "X-RapidAPI-Host")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("❌ ExerciseDB API error: \(error)")
                return
            }

            guard let data = data else {
                print("❌ No data from ExerciseDB.")
                return
            }

            do {
                try data.write(to: cacheURL())
                print("✅ ExerciseDB data saved to local cache.")
            } catch {
                print("❌ Failed to save ExerciseDB data: \(error)")
            }
        }.resume()
    }

    static func cacheURL() -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("exerciseDB.json")
    }
}

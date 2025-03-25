//
//  WgerAPIService.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import Foundation

class WgerAPIService {
    static let shared = WgerAPIService()
    private init() {}

    private let baseURL = "https://wger.de/api/v2/"
    private let session = URLSession.shared

    // MARK: - Public Entry Point
    func fetchExercises(completion: @escaping ([Exercise]) -> Void) {
        guard let url = URL(string: "https://wger.de/api/v2/exerciseinfo/?limit=1000") else {
            print("❌ Invalid Wger URL.")
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Wger API error: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("❌ No data from Wger API.")
                completion([])
                return
            }

            // DEBUG: Print raw JSON to inspect the structure
            if let raw = String(data: data, encoding: .utf8) {
                print("🔍 RAW WGER JSON RESPONSE:")
                print(raw.prefix(2000)) // avoid overload
            }

            do {
                let decoded = try JSONDecoder().decode(WgerExerciseResponse.self, from: data)
                let matcher = GIFMatcher()
                let converted = decoded.results.map { $0.toExercise(using: matcher) }
                completion(converted)
            } catch {
                print("❌ Decoding error: \(error)")
                completion([])
            }
        }

        task.resume()
    

    }
}

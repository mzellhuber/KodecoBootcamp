//
//  ApiService.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import Foundation

class ApiService {
    private let baseUrl = "https://api.edamam.com/search"
    private let mealPlannerUrl = "https://api.edamam.com/api/meal-planner/v1"
    private let appId = "e212b61f"
    private let appKey = "790c8611317cfbe37040555011d5c387"
    private let mealPlanAppId = "ace62b9f"
    private let mealPlanAppKey = "d63b97c069015e1d981f048d2c3eaf27"

    func fetchRecipes(query: String, from: Int, to: Int) async throws -> [Recipe] {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseUrl)?q=\(queryEncoded)&app_id=\(appId)&app_key=\(appKey)&from=\(from)&to=\(to)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        /*
         if let jsonStr = String(data: data, encoding: .utf8) {
         print("JSON Response: \(jsonStr)")
         }
         */
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        }
        do {
            let decodedResponse = try JSONDecoder().decode(EdamamResponse.self, from: data)
            return decodedResponse.hits.map { $0.recipe }
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
    
    func createMealPlan(query: String, size: Int, dietLabels: [String], healthLabels: [String], mealType: String, calorieMin: Int, calorieMax: Int) async throws -> [Recipe] {
        let calorieRange = "\(calorieMin)-\(calorieMax)"

        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid base URL"])
        }

        var queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "app_id", value: mealPlanAppId),
            URLQueryItem(name: "app_key", value: mealPlanAppKey),
            URLQueryItem(name: "from", value: "0"),
            URLQueryItem(name: "to", value: String(size)),
            URLQueryItem(name: "calories", value: calorieRange),
            URLQueryItem(name: "mealType", value: mealType)
        ]

        for dietLabel in dietLabels {
            queryItems.append(URLQueryItem(name: "diet", value: dietLabel))
        }

        for healthLabel in healthLabels {
            queryItems.append(URLQueryItem(name: "health", value: healthLabel))
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        print("Request URL: \(url)")

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        }

        do {
            let decodedResponse = try JSONDecoder().decode(EdamamResponse.self, from: data)
            return decodedResponse.hits.map { $0.recipe }
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
}

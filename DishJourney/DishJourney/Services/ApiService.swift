//
//  ApiService.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import Foundation

class ApiService {
    private let baseUrl = "https://api.edamam.com/search"
    private let appId = "e212b61f"
    private let appKey = "790c8611317cfbe37040555011d5c387"

    func fetchRecipes(query: String) async throws -> [Recipe] {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseUrl)?q=\(queryEncoded)&app_id=\(appId)&app_key=\(appKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        }
        
        let decodedResponse = try JSONDecoder().decode(EdamamResponse.self, from: data)
        return decodedResponse.hits.map { $0.recipe }
    }
}

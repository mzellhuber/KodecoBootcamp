//
//  PexelsStore.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

class PexelsStore {
    private var apiKey: String {
        ConfigManager.shared.apiKey
    }

    func searchPhotos(query: String, perPage: Int = 15) async throws -> PexelsResponse {
        let urlString = "https://api.pexels.com/v1/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&per_page=\(perPage)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(PexelsResponse.self, from: data)
    }
}

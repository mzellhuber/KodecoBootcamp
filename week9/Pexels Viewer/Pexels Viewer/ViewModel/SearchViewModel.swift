//
//  SearchViewModel.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var searchQuery = ""

    private let store = PexelsStore()

    func searchPhotos() async {
        guard !searchQuery.isEmpty else {
            photos = []
            return
        }

        do {
            let response = try await store.searchPhotos(query: searchQuery)
            photos = response.photos
        } catch {
            print("Error searching photos: \(error)")
        }
    }
}

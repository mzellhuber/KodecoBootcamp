//
//  SearchViewModel.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var searchQuery = ""
    private var searchTask: Task<Void, Never>? = nil

    private let store = PexelsStore()

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) {
        searchTask?.cancel() 

        guard query.count > 3 else {
            photos = []
            return
        }

        searchTask = Task {
            do {
                let response = try await store.searchPhotos(query: query)
                self.photos = response.photos
            } catch {
                print("Error searching photos: \(error)")
            }
        }
    }
}

//
//  SearchView.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Pexels", text: $viewModel.searchQuery)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .submitLabel(.search)
                
                if viewModel.searchQuery.isEmpty {
                    EmptyStateView(message: "Start by searching for images.")
                } else if viewModel.searchQuery.count < 3 {
                    EmptyStateView(message: "Type more than 3 letters to search.")
                } else if viewModel.photos.isEmpty {
                    EmptyStateView(message: "No results found.")
                } else {
                    photoGrid()
                }
                
            }
            .navigationTitle("Pexels Search")
        }
    }
    
    func photoGrid() -> some View {
        ScrollView {
            HStack(alignment: .top, spacing: 5) {
                let columnCount = 2
                ForEach(0..<columnCount, id: \.self) { columnIndex in
                    LazyVStack(spacing: 5) {
                        ForEach(0..<viewModel.photos.count, id: \.self) { index in
                            if index % columnCount == columnIndex {
                                let photo = viewModel.photos[index]
                                NavigationLink(destination: DetailView(photo: photo)) {
                                    AsyncImage(url: URL(string: photo.src.medium)) { imagePhase in
                                        switch imagePhase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 150 * CGFloat(photo.height) / CGFloat(photo.width))
                                                .clipped()
                                        case .failure:
                                            Image(systemName: "photo")
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

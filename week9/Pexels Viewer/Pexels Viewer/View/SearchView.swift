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
                TextField("Search", text: $viewModel.searchQuery)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewModel.searchPhotos()
                        }
                    }

                List(viewModel.photos) { photo in
                    NavigationLink(destination: DetailView(photo: photo)) {
                        HStack {
                            AsyncImage(url: URL(string: photo.src.small)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(photo.photographer)
                                    .fontWeight(.bold)
                                Text(photo.alt)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pexels Search")
        }
    }
}

#Preview {
    SearchView()
}

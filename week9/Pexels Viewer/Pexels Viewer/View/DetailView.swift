//
//  DetailView.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo
    @State private var showLarge2X = false

    var body: some View {
        ScrollView {
            VStack {
                Button(action: { showLarge2X.toggle() }) {
                    Text(showLarge2X ? "1x" : "2x")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }

                if showLarge2X {
                    AsyncImage(url: URL(string: photo.src.large2X)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .cornerRadius(10)
                                .padding()
                        case .failure:
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.secondary)
                                .padding()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    AsyncImage(url: URL(string: photo.src.large)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .padding()
                        case .failure:
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.secondary)
                                .padding()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                VStack(alignment: .center, spacing: 8) {
                    Text(photo.photographer)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    Text(photo.alt)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding([.horizontal, .bottom])
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

//
//  DetailView.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.src.large)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
        }
        .navigationTitle(photo.photographer)
        .padding()
    }
}

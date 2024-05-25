//
//  CachedImageView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import SwiftUI

struct CachedImageView: View {
  @StateObject private var imageLoader: ImageCache

  init(urlString: String) {
    _imageLoader = StateObject(wrappedValue: ImageCache(urlString: urlString))
  }

  var body: some View {
    Group {
      if let image = imageLoader.image {
        Image(uiImage: image)
          .resizable()
      } else {
        ProgressView()
      }
    }
  }
}

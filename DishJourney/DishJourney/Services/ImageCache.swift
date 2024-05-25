//
//  ImageCache.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 12/05/24.
//

import UIKit
import Combine

class ImageCache: ObservableObject {
  @Published var image: UIImage?
  var urlString: String

  init(urlString: String) {
    self.urlString = urlString
    loadImage()
  }

  func loadImage() {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data)
      }
    }
    .resume()
  }
}

//
//  PhotoSource.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

// MARK: - Src
struct Src: Codable {
    let original, large2X, large, medium: String
    let small, portrait, landscape, tiny: String

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}

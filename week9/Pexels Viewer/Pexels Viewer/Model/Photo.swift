//
//  Photo.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
    let src: PhotoSource
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerUrl = "photographer_url"
        case photographerId = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }
}

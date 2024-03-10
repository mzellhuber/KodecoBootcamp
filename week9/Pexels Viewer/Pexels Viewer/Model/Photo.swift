//
//  Photo.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let id, width, height: Int
    let url: String
    let photographer: String
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: Src
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }
}

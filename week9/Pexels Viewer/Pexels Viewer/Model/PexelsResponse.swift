//
//  PexelsResponse.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

struct PexelsResponse: Codable {
    let totalResults: Int
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let nextPage: String

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
        case nextPage = "next_page"
    }
}

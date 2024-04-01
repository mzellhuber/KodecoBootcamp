//
//  PexelsResponse.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

// MARK: - PexelsResponse
struct PexelsResponse: Codable {
    let page, per_page: Int?
    let photos: [Photo]
    let total_results: Int?
    let next_page: String?
}

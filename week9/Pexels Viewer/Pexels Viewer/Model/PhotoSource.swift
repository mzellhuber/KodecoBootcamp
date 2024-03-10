//
//  PhotoSource.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import Foundation

struct PhotoSource: Codable {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}

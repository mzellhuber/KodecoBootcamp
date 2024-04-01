//
//  ConfigManager.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 09/03/24.
//

import Foundation

class ConfigManager {
    static let shared = ConfigManager()

    private init() {}

    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Pexels-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Pexels-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Pexels-Info.plist'.")
        }
        if (value.starts(with: "_")) {
            fatalError("Register for a Pexels developer account and get an API key at https://www.pexels.com/api/new/.")
        }
        return value
    }
}

//
//  FetchApiKey.swift
//  GenAI
//
//  Created by Shakti on 08/12/24.
//

import Foundation

enum APIKey{
    static var `default`: String {
        // Fetch the API key from Gen-AI.plist
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("Couldn't find desired file.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find API_KEY in 'Gen-AI.plist'.")
        }
        if value.starts(with: "_"){
            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get the API key.")
        }
        return value
    }
}

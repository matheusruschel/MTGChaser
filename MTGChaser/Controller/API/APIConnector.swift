//
//  APIConnector.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

actor APIConnector: APIConnectable {
    
    var headers: [String: String]
    
    init(headers: [String: String]) {
        self.headers = headers
    }
    
    func get(url: URL) async throws -> Data {
        
        var request = URLRequest(url: url)
        
        headers.forEach { key, value in
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
        
        let (data, _) = try await URLSession.shared.data(from: request.url!)
        return data
    }
}


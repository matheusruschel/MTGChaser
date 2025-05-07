//
//  CardFetcher.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

let baseURLString = "https://api.scryfall.com"
let setsURLString = baseURLString + "/sets"

struct ScryfallSearchURLQuery {
    var query: String
    var sortOrder: SortOrder = .rarity
    
    func toURL() -> URL? {
        var queryStringComponents = URLComponents(string: baseURLString + "/cards/search")
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: "q", value: query))
        
        queryItems.append(URLQueryItem(name: "include_extras", value: "true"))
        queryItems.append(URLQueryItem(name: "include_variations", value: "true"))
        queryItems.append(URLQueryItem(name: "unique", value: "prints"))
        
        if sortOrder == .rarity {
            queryItems.append(URLQueryItem(name: "order", value: "rarity"))
        }
        
        queryStringComponents?.queryItems = queryItems
        
        return queryStringComponents?.url
    }
}

actor ScryfallFetcher {
    
    var connector: APIConnectable
    
    static let scryfallHeaders =
    ["User-Agent": "MTGExampleApp/1.0",
     "Accept": "application/json"]
    
    init(connector: APIConnectable = APIConnector(headers: scryfallHeaders)) {
        self.connector = connector
    }
    
    func fetchSets() async throws -> ScryfallAPIResponse<CardSet>? {
        return try await get(urlString: setsURLString)
    }
    
    func searchForCards(query: String, sortOrder: SortOrder = .rarity) async throws ->  ScryfallAPIResponse<Card>? {
        
        let urlQuery = ScryfallSearchURLQuery(query: query, sortOrder: sortOrder)
        
        guard let url = urlQuery.toURL() else {
            throw Errors.invalidUrl
        }
        
        return try await get(url: url)
    }
    
    func fetchNextPage(urlString: String) async throws -> ScryfallAPIResponse<Card>? {
        return try await get(urlString: urlString)
    }
    
    private func get<T:Decodable>(urlString: String) async throws -> ScryfallAPIResponse<T>? {
        
        guard let url = URL(string: urlString) else {
            throw Errors.invalidUrl
        }
        
        let returnObject = try await connector.get(url: url)
        
        let object = try JSONDecoder().decode(ScryfallAPIResponse<T>.self, from: returnObject)
        
        return object
    }
    
    private func get<T:Decodable>(url: URL) async throws -> ScryfallAPIResponse<T>? {
        
        let returnObject = try await connector.get(url: url)
        
        let object = try JSONDecoder().decode(ScryfallAPIResponse<T>.self, from: returnObject)
        
        return object
    }
}

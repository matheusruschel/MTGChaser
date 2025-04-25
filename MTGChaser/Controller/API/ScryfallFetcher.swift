//
//  CardFetcher.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

let baseURLString = "https://api.scryfall.com"
let setsURLString = baseURLString + "/sets"
let collectionURLString = baseURLString + "/cards/collection"

actor ScryfallFetcher {
    
    var connector: APIConnectable
    
    static let scryfallHeaders =
    ["User-Agent": "MTGExampleApp/1.0",
     "Accept": "application/json"]
    
    init(connector: APIConnectable = APIConnector(headers: scryfallHeaders)) {
        self.connector = connector
    }
    
    func fetchCards(searchUri: String) async throws -> ScryfallAPIResponse<Card>? {
        return try await get(url: searchUri)
    }
    
    func fetchSets() async throws -> ScryfallAPIResponse<CardSet>? {
        return try await get(url: setsURLString)
    }
    
    private func get<T:Decodable>(url: String) async throws -> ScryfallAPIResponse<T>? {
        
        guard let setUrl = URL(string: url) else {
            throw Errors.invalidUrl
        }
        
        let returnObject = try await connector.get(url: setUrl)
        
        let object = try JSONDecoder().decode(ScryfallAPIResponse<T>.self, from: returnObject)
        
        return object
    }
}

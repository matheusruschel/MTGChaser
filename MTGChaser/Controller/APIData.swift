//
//  CardSetListData.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

enum SortOrder {
    case rarity
    case price
    case cmc
}

struct APIDataReturn<T: Sendable>: Sendable {
    var data: [T]
    var nextPage: String?
}

actor APIData {
    
    let scryfallFetcher = ScryfallFetcher()
    
    func fetchCardSetList() async -> APIDataReturn<CardSet>? {
        do {
            let scryfallAPIResponse = try await scryfallFetcher.fetchSets()
            
            guard let cardSetListData = scryfallAPIResponse?.data else {
                return nil
            }
            
            return APIDataReturn(data: cardSetListData, nextPage: scryfallAPIResponse?.next_page)
        } catch {
            print("Error fetching card set list: \(error)")
            return nil
        }
    }
    
    func fetchCards(queryString: String, sortOrder: SortOrder = .rarity) async -> APIDataReturn<Card>? {
        do {
            
            let scryfallAPIResponse = try await scryfallFetcher.searchForCards(query: queryString)
            
            guard let cardsData = scryfallAPIResponse?.data else {
                return nil
            }
            
            return APIDataReturn(data: cardsData, nextPage: scryfallAPIResponse?.next_page)
        } catch {
            print("Error fetching cards: \(error)")
            return nil
        }
    }
}

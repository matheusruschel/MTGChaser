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
    
    func fetchCardSetList(setType: SetType = .expansion) async -> APIDataReturn<CardSet>? {
        do {
            let scryfallAPIResponse = try await scryfallFetcher.fetchSets()
            
            guard let cardSetListData = scryfallAPIResponse?.data else {
                return nil
            }
            
            return APIDataReturn(data: cardSetListData.filter({ $0.set_type == setType }), nextPage: scryfallAPIResponse?.next_page)
        } catch {
            print("Error fetching card set list: \(error)")
            return nil
        }
    }
    
    func fetchCards(searchUri: String, sortOrder: SortOrder? = nil) async -> APIDataReturn<Card>? {
        do {
            let scryfallAPIResponse = try await scryfallFetcher.fetchCards(searchUri: searchUri)
            
            guard var cardsData = scryfallAPIResponse?.data else {
                return nil
            }
            
            if let sortOrder = sortOrder {
                cardsData.sort { (card1, card2) -> Bool in
                    card1.rarity > card2.rarity
                }
            }
            
            return APIDataReturn(data: cardsData, nextPage: scryfallAPIResponse?.next_page)
        } catch {
            print("Error fetching cards: \(error)")
            return nil
        }
    }
    
}

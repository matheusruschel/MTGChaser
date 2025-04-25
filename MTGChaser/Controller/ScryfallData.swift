//
//  CardSetListData.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

@MainActor
class ScryfallData {
    
    let scryfallFetcher = ScryfallFetcher()
    
    func fetchCardSetList(setType: SetType = .expansion) async -> [CardSet]? {
        do {
            let cardSetListData = try await scryfallFetcher.fetchSets()
            return cardSetListData.filter({ $0.set_type == setType })
        } catch {
            print("Error fetching card set list: \(error)")
            return nil
        }
    }
    
    func fetchCards(searchUri: String) async -> [Card]? {
        do {
            let cardsData = try await scryfallFetcher.fetchCards(searchUri: searchUri)
            return cardsData
        } catch {
            print("Error fetching cards: \(error)")
            return nil
        }
    }
    
}

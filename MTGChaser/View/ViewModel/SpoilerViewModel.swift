//
//  SpoilerViewModel.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-29.
//

import Foundation
import Combine

@MainActor
class SpoilerViewModel: ObservableObject {
    
    var scryfallFetcher = ScryfallFetcher()

    @Published
    var cardSetReturnData: ScryfallAPIResponse<CardSet>?

    var cardsDataPerSet: [String: ScryfallAPIResponse<Card>] = [:]
    @Published
    private var expandedSetIds: Set<String> = []
    
    init() {
        print("init")
    }
    
    func prefetchCardsIfNeeded(for set: CardSet, sortOrder: SortOrder? = .rarity) {
        if cardsDataPerSet[set.id] == nil {
            Task {
                if let cardsData = try await scryfallFetcher.searchForCards(query:"e:\(set.code)") {
                    print("URL \(set.search_uri)")
                    
                    cardsDataPerSet[set.id] = cardsData
                }
            }
        }
    }
    
    func isSetExpanded(setId: String) -> Bool {
        return expandedSetIds.contains(setId)
    }
    
    func fetchCardSetData(setType: SetType = .expansion) {
        Task {
            if var cardSetReturnData = try await scryfallFetcher.fetchSets() {
                cardSetReturnData.data = cardSetReturnData.data?.filter({ $0.set_type == setType && $0.card_count > 0})
                
                self.cardSetReturnData = cardSetReturnData
            }
        }
    }
    
    func toggleSet(_ id: String) {
        
        if expandedSetIds.contains(id) {
            expandedSetIds.remove(id)
        } else {
            expandedSetIds.insert(id)
        }
    }
    
}

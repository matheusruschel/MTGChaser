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
    
    var cardSetData = APIData()
    var scryfallFetcher = APIData()
    
    @Published
    var cardSetReturnData: APIDataReturn<CardSet>?
    @Published
    var cardsDataPerSet: [String: APIDataReturn<Card>] = [:]
    @Published
    private var expandedSetIds: Set<String> = []
    
    func prefetchCardsIfNeeded(for set: CardSet, sortOrder: SortOrder? = .rarity) {
        if cardsDataPerSet[set.id] == nil {
            Task {
                if var cardsData = await scryfallFetcher.fetchCards(searchUri: set.search_uri.replaceSortOrderWithRariry()) {
                    print("URL \(set.search_uri.replaceSortOrderWithRariry())")
                    
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
            if var cardSetReturnData = await cardSetData.fetchCardSetList() {
                cardSetReturnData.data = cardSetReturnData.data.filter({ $0.set_type == setType && $0.card_count > 0})
                
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

extension String {
    func replaceSortOrderWithRariry() -> String {
        return self.replacingOccurrences(of: "order=set", with: "order=rarity")
    }
}

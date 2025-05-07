//
//  CardListViewModel.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-07.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class CardListViewModel: ObservableObject {
    
    var scryfallFetcher = ScryfallFetcher()
    var nextPage: String?
    var isLoading: Bool = false
    
    @Published
    var cards: [Card]
    
    init(scryfallFetcher: ScryfallFetcher = ScryfallFetcher(),
         cards: [Card]?,
         nextPage: String?) {
        
        self.scryfallFetcher = scryfallFetcher
        self.cards = cards ?? []
        self.nextPage = nextPage

    }
    
    func fetchNextPageIfLastElement(card: Card) {
        if cards.last?.id == card.id && !self.isLoading, let nextPage = nextPage {
            self.isLoading = true
            
            Task {
                let cardsData = try await scryfallFetcher.fetchNextPage(urlString: nextPage)
                self.nextPage = cardsData?.next_page
                self.cards.append(contentsOf: cardsData?.data ?? [])
                self.isLoading = false
            }
        }
    }
}

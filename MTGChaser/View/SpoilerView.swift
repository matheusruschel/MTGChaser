//
//  SpoilerView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//
import SwiftUI

@MainActor
struct SpoilerView: View {
    
    private var cardSetData = APIData()
    var scryfallFetcher = APIData()
    
    @State
    var cardSetReturnData: APIDataReturn<CardSet>?
    @State
    var cardsDataPerSet: [String: APIDataReturn<Card>] = [:]
    
    @State
    var expandedSetIds: Set<String> = []
    
    private func prefetchCardsIfNeeded(for set: CardSet) {
        if cardsDataPerSet[set.id] == nil {
            Task {
                if let cards = await scryfallFetcher.fetchCards(searchUri: set.search_uri.replaceSortOrderWithRariry(), sortOrder: .rarity) {
                    cardsDataPerSet[set.id] = cards
                }
            }
        }
    }
    
    private func toggleSet(_ id: String) {
        if expandedSetIds.contains(id) {
            expandedSetIds.remove(id)
        } else {
            expandedSetIds.insert(id)
        }
    }
    
    init() {
        
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(cardSetReturnData?.data ?? []) { set in
                        Section(content: {
                            
                            if expandedSetIds.contains(set.id), let cardsData = cardsDataPerSet[set.id] {
                                CardPerSetListView(cardsData: cardsData)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                            
                        }, header: {
                            SetHeaderView(cardSet: set, isExpanded: expandedSetIds.contains(set.id), toggleExpanded: toggleSet)
                                .onAppear {
                                    prefetchCardsIfNeeded(for: set)
                                }
                            
                        })
                    }
                }
            }
        }
        .onAppear {
            Task { cardSetReturnData = await cardSetData.fetchCardSetList() }
        }
    }
}

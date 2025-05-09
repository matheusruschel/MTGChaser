//
//  SearchView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-02.
//


import SwiftUI

@MainActor
struct SearchView: View {
    
    @Binding
    var onSubmit: Bool
    
    var searchQuery: String
    
    @State
    var cardsSearched: ScryfallAPIResponse<Card>?
    
    let scryfallFetcher = ScryfallFetcher()
    
    var body: some View {
        VStack {
            if let cardsSearched = cardsSearched {
                CardListView(viewModel: CardListViewModel(cards: cardsSearched.data, nextPage: cardsSearched.next_page))
            }
        }
        .onChange(of: onSubmit) {
            runSearch()
            onSubmit = false
        }
        .onAppear {
            if onSubmit && !searchQuery.isEmpty {
                runSearch()
            }
        }
    }
    
    func runSearch() {
        print("running search")
        Task {
            let cardsSearchedObject = try await scryfallFetcher.searchForCards(query: searchQuery)
            
            Task { @MainActor in
                cardsSearched = cardsSearchedObject
            }
        }
    }
}

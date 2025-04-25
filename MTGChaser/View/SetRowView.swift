//
//  SetRowView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct SetRowView: View {
    
    var cardSet: CardSet
    @State
    var isExpanded: Bool = false
    
    @State
    var cards: [Card] = []
    var scryfallFetcher = ScryfallData()
    
    var body: some View {
        VStack {
            HStack {
                SVGImageView(url: URL(string: cardSet.icon_svg_uri)!, size: CGSize(width: 30, height: 30))
                            .frame(width: 30, height: 30)
                Text(cardSet.name)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(5)
                Spacer()
                ChevronButton(isExpanded: $isExpanded)
            }
            .padding().frame(height: 50)
            .background(Color(.lightGray))
            
            if isExpanded {
                CardListView(cards: cards)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .onAppear {
            Task { cards = await scryfallFetcher.fetchCards(searchUri: cardSet.search_uri) ?? [] }
        }
    }
    
}

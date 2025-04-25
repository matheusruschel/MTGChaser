//
//  SetRowView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct SetRowView: View {
    
    var cardSet: CardSet
    var scryfallFetcher = APIData()
    
    @State
    var isExpanded: Bool = false
    
    @State
    var cardsData: APIDataReturn<Card>?
    
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
            
            if let cardsData = cardsData, isExpanded {
                CardListView(cardsData: cardsData)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .onAppear {
            Task {
                cardsData = await scryfallFetcher.fetchCards(searchUri: cardSet.search_uri.replaceSortOrderWithRariry(), sortOrder: .rarity)
            }
        }
    }
    
}

extension String {
    func replaceSortOrderWithRariry() -> String {
        return self.replacingOccurrences(of: "order=set", with: "order=rarity")
    }
}

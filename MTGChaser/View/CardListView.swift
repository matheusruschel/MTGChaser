//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct CardListView: View {
    
    let columns = [GridItem(.flexible())]
    
    private var cards: [Card] = []
    
    init(cards: [Card] ) {
        self.cards = cards
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(cards) { card in
                    
                }
            }
        }
    }
}

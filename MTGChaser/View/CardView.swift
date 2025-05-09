//
//  CardView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-30.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    @State
    var card: Card
    
    var body: some View {
        
        VStack {
            if card.layout != .reversible_card, let imageUrl = card.image_uris?.normal {
                SingleFaceCardView(imageUrl: imageUrl)
            } else {
                ReversibleCardView(card: card)
            }
            
            CardDetailsView(card: card)
            Spacer()
        }
        .cornerRadius(8)
    }
    
    
}
    

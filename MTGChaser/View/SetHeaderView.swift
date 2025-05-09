//
//  SetRowView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

@MainActor
struct SetHeaderView: View {
    
    var cardSet: CardSet
    
    var isExpanded: Bool
    var toggleExpanded: (String) -> Void

    var body: some View {
        VStack {
            HStack {
                SVGImageView(url: URL(string: cardSet.icon_svg_uri)!,
                             size: CGSize(width: 30, height: 30),
                             color: .appTertiary)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, 2)
                
                VStack {
                    HStack {
                        Text(cardSet.name)
                            .foregroundColor(.appTertiary)
                            .font(.system(size: 17) .weight(.bold))
                        Spacer()
                    }
                    .padding(.bottom, 2)

                    HStack {
                        HStack {
                            Text("\(cardSet.card_count) cards")
                                .font(.system(size: 12))
                                .foregroundColor(Color.gray)
                            Text("⬤")
                                .font(.system(size: 7))
                                .foregroundColor(.gray)
                            Text("Released \(cardSet.released_at)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                
                ChevronIconView(isExpanded: isExpanded)
                    .padding(.trailing, 5)
            }
            .padding()
        }
        .background(Color(.appSecondary))
        .onTapGesture {
            //withAnimation {
                toggleExpanded(cardSet.id)
           // }
        }
    }
    
}

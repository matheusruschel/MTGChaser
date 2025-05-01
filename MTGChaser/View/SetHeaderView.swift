//
//  SetRowView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct SetHeaderView: View {
    
    var cardSet: CardSet
    
    var isExpanded: Bool
    var toggleExpanded: (String) -> Void

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
                ChevronIconView(isExpanded: isExpanded)
            }
            .padding().frame(height: 50)
            .background(Color(.lightGray))
            .onTapGesture {
                toggleExpanded(cardSet.id)
            }
        }
    }
    
}

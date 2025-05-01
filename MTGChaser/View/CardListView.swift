//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardListView: View {
    
    private var cardsData: APIDataReturn<Card>
    
    @State
    var columns = [GridItem(.flexible())]
    
    @State
    private var displayMode = 0
    
    init(cardsData: APIDataReturn<Card> ) {
        self.cardsData = cardsData
    }
    
    var body: some View {
        VStack {
            Picker("Display mode", selection: $displayMode) {
                Text("One row").tag(0)
                Text("Two rows").tag(1)
                Text("Three rows").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.top, 5)
            .padding(.bottom, 10)

            LazyVGrid(columns: columns) {
                ForEach(cardsData.data) { card in
                    CardView(card: card)
                }
            }
        }
        .padding(.horizontal, 5)
        .onChange(of: displayMode) {
            switch displayMode {
            case 0:
                columns = [GridItem(.flexible())]
            case 1:
                columns = [GridItem(.flexible()), GridItem(.flexible())]
            default:
                columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            }
        }
    }
}

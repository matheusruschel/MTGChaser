//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardListView: View {
    
    private var cardsData: ScryfallAPIResponse<Card>
    
    @State
    var columns = [GridItem(.flexible())]
    
    @State
    private var displayMode = 0
    
    init(cardsData: ScryfallAPIResponse<Card> ) {
        self.cardsData = cardsData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Display mode", selection: $displayMode) {
                    Text("One row").tag(0)
                    Text("Two rows").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.top, 5)
                .padding(.bottom, 10)

                LazyVGrid(columns: columns) {
                    ForEach(cardsData.data ?? []) { card in
                        CardView(card: card)
                    }
                }
            }
            .padding(.horizontal, 5)
            .onChange(of: displayMode) {
                switch displayMode {
                case 0:
                    columns = [GridItem(.flexible())]
                default:
                    columns = [GridItem(.flexible()), GridItem(.flexible())]
                }
            }
        }

    }
}

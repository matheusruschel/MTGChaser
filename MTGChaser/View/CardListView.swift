//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardListView: View {
    
    @EnvironmentObject var settings: Settings
    
    let scryfallData = ScryfallFetcher()
    private var cardsData: ScryfallAPIResponse<Card>
    
    @State
    var columns = [GridItem(.flexible())]
    
    init(cardsData: ScryfallAPIResponse<Card> ) {
        self.cardsData = cardsData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(cardsData.data ?? []) { card in
                        CardView(card: card)
                    }
                }
            }
            .padding(.horizontal, 5)
            .onChange(of: settings.displayMode) {
                switch settings.displayMode {
                case 0:
                    columns = [GridItem(.flexible())]
                default:
                    columns = [GridItem(.flexible()), GridItem(.flexible())]
                }
            }
            .onAppear {
                columns = settings.displayMode == 0 ? [GridItem(.flexible())] : [GridItem(.flexible()), GridItem(.flexible())]
            }
        }
    }
}

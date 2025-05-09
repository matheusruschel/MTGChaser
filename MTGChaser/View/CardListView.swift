//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct CardListView: View {
    
    @EnvironmentObject var settings: Settings
    
    @StateObject
    var viewModel: CardListViewModel
    
    @State
    var columns = [GridItem(.flexible())]
    
    func selectDisplayMode(displayMode: Int) {
        switch displayMode {
            case 0: columns = [GridItem(.flexible())]
            case 1: columns = [GridItem(.flexible()), GridItem(.flexible())]
            case 2: columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            default: columns = [GridItem(.flexible())]
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.cards, id: \.self) { card in
                    CardView(card: card)
                        .onAppear {
                            viewModel.fetchNextPageIfLastElement(card: card)
                        }
                }
            }
            .padding(.horizontal, 5)
            .onChange(of: settings.displayMode) {
                selectDisplayMode(displayMode: settings.displayMode)
            }
            .onAppear {
                selectDisplayMode(displayMode: settings.displayMode)
            }
        }
    }
}

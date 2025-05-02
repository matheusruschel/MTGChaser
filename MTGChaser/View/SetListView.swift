//
//  SetListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-02.
//

import SwiftUI

@MainActor
struct SetListView: View {
    
    @ObservedObject
    var viewModel: SpoilerViewModel
    
    var body: some View {
        LazyVStack(pinnedViews: [.sectionHeaders]) {
            ForEach(viewModel.cardSetReturnData?.data ?? []) { set in
                Section(content: {
                    
                    if viewModel.isSetExpanded(setId: set.id), let cardsData = viewModel.cardsDataPerSet[set.id] {
                        CardListView(cardsData: cardsData)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                }, header: {
                    SetHeaderView(cardSet: set, isExpanded: viewModel.isSetExpanded(setId: set.id), toggleExpanded: viewModel.toggleSet)
                        .onAppear {
                            viewModel.prefetchCardsIfNeeded(for: set)
                        }
                })
            }
        }
    }
}

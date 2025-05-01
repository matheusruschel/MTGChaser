//
//  SpoilerView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//
import SwiftUI

@MainActor
struct SpoilerView: View {
    
    @ObservedObject
    var viewModel: SpoilerViewModel = SpoilerViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
            .navigationTitle("Sets")
        }
        .onAppear {
            viewModel.fetchCardSetData()
        }
    }
}

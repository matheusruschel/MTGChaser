//
//  SpoilerView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//
import SwiftUI

@MainActor
struct SpoilerView: View {
    
    let columns = [GridItem(.flexible())]
    
    private var cardSetData = ScryfallData()
    
    @State
    var cardSetList: [CardSet] = []
    
    var body: some View {
        VStack {
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(cardSetList) { set in
                        VStack {
                            SetRowView(cardSet: set)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task { cardSetList = await cardSetData.fetchCardSetList() ?? [] }
        }
    }
}

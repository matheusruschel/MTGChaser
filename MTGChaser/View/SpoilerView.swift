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
    
    private var cardSetData = APIData()
    
    @State
    var cardSetReturnData: APIDataReturn<CardSet>?
    
    var body: some View {
        VStack {
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(cardSetReturnData?.data ?? []) { set in
                        VStack {
                            SetRowView(cardSet: set)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task { cardSetReturnData = await cardSetData.fetchCardSetList() }
        }
    }
}

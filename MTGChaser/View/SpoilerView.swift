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
    
    @State private var searchQuery = ""
    @State private var searchIsActive = false
    @State private var onSubmit: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("MTG sets")
                        .font(.custom("Cinzel-Bold", size: 24))
                        .foregroundStyle(.appTertiary)
                    Spacer()
                }
                .frame(height: 30)
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        QuerySearchBar(onSubmit: $onSubmit, searchQuery: $searchQuery, searchIsActive: $searchIsActive)
                        ZStack {
                            
                            if searchIsActive {
                                SearchView(onSubmit: $onSubmit, searchQuery: searchQuery)
                            } else {
                                SetListView(viewModel: viewModel)
                            }
                        }
                    }
                }
            }
            .background(Color.appSecondary)
        }
        .onAppear {
            viewModel.fetchCardSetData()
        }
    }
}

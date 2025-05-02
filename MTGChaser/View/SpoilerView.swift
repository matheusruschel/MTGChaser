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
    
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextField("Search", text: $searchQuery)
                        .focused($isSearchFieldFocused)
                        .onSubmit {
                            onSubmit = true
                        }
                        .padding()
                    ZStack {
                        SearchView(onSubmit: $onSubmit, searchQuery: searchQuery)
                            .opacity(!searchQuery.isEmpty || isSearchFieldFocused ? 1 : 0)
                        
                        SetListView(viewModel: viewModel)
                            .opacity(searchQuery.isEmpty && !isSearchFieldFocused ? 1 : 0)
                    }
                }
            }
            .navigationTitle("Sets")
            
        }
        .onTapGesture {
            isSearchFieldFocused = false
        }
        .onAppear {
            viewModel.fetchCardSetData()
        }
    }
}

//
//  QuerySearchBar.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-05.
//

import SwiftUI

@MainActor
struct QuerySearchBar: View {
    
    @Binding
    var onSubmit: Bool
    @Binding 
    var searchQuery: String
    @Binding
    var searchIsActive: Bool
    
    @FocusState
    private var isSearchFieldFocused: Bool
    
    var body: some View {
        HStack {
            
            if searchIsActive {
                Image(systemName: "arrow.backward")
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.1)) {
                            onSubmit = false
                            searchIsActive = false
                            isSearchFieldFocused = false
                        }
                    }
                    .foregroundColor(.appTertiary)
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.appTertiary)
                    .padding(.leading, 8)

                TextField("", text: $searchQuery)
                    .placeholder("Search for cards using Scryfall notation...",
                                 when: searchQuery.isEmpty,
                                 withGradient: [.red,.blue])
                    .font(.system(size: 15))
                    .foregroundStyle(.appTertiary)
                    .focused($isSearchFieldFocused)
                    .onSubmit {
                        onSubmit = true
                    }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.appTertiary)
                    .frame(height: 40)
            )
        }
        .padding()
        .onChange(of: searchQuery) { _,newValue in
            onSubmit = false
        }
        .onChange(of: isSearchFieldFocused) { _,newValue in
            withAnimation(.snappy(duration: 0.1)) {
                
                if isSearchFieldFocused {
                    
                    searchIsActive = true
                    
                    if !searchQuery.isEmpty {
                        searchIsActive = true
                        onSubmit = true
                    }
                }
            }
        }
    }
}

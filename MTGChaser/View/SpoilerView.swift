//
//  SpoilerView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//
import SwiftUI

@MainActor
struct SpoilerView: View {
    
    @StateObject
    var viewModel: SpoilerViewModel = SpoilerViewModel()
    
    @State private var searchQuery = ""
    @State private var searchIsActive = false
    @State private var onSubmit: Bool = false

    @StateObject
    private var settings = Settings()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("MTG sets")
                        .font(.custom("Cinzel-Bold", size: 24))
                        .foregroundStyle(.appTertiary)
                    Spacer()
                    Picker("Display mode", selection: $settings.displayMode) {
                        Text("One row").tag(0)
                        Text("Two rows").tag(1)
                        Text("Three rows").tag(2)
                    }
                    .pickerStyle(.segmented)

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
        .environmentObject(settings)
    }
}

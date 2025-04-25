//
//  CardListView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardListView: View {
    
    private var cardsData: APIDataReturn<Card>
    
    @State
    var columns = [GridItem(.flexible())]
    
    @State
    private var displayMode = 0
    
    init(cardsData: APIDataReturn<Card> ) {
        self.cardsData = cardsData
    }
    
    var body: some View {
        VStack {
            Picker("Display mode", selection: $displayMode) {
                Text("One row").tag(0)
                Text("Two rows").tag(1)
                Text("Three rows").tag(2)
            }
            .pickerStyle(.segmented)
            
            LazyVGrid(columns: columns) {
                ForEach(cardsData.data) { card in
                    VStack {
                        if let imageUrl = card.image_uris?.normal {
                            WebImage(url: imageUrl) { image in
                                    image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                                } placeholder: {
                                        Rectangle().foregroundColor(.gray)
                                }
                                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                                .onSuccess { image, data, cacheType in
                                    // Success
                                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                                }
                                .onFailure { error in
                                    print("error")
                                }
                                .indicator(.activity) // Activity Indicator
                                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                                .scaledToFit()
                        }
                    }
                }
            }
        }
        .padding()
        .onChange(of: displayMode) {
            switch displayMode {
            case 0:
                columns = [GridItem(.flexible())]
            case 1:
                columns = [GridItem(.flexible()), GridItem(.flexible())]
            default:
                columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
            }
        }
    }
}

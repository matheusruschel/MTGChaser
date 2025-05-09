//
//  SingleFaceCardView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleFaceCardView: View {
    
    var imageUrl:URL
    
    var body: some View {
        
        WebImage(url: imageUrl) { image in
            image.resizable()
        } placeholder: {
            Rectangle().foregroundColor(.gray)
        }
        // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
        .onSuccess { image, data, cacheType in
            // Success
            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
        }
        .onFailure { error in
            print("error loading card image")
        }
        .indicator(.activity) // Activity Indicator
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
    }
}

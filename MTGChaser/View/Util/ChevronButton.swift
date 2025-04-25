//
//  ChevronButton.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct ChevronButton: View {
    
    @Binding var isExpanded: Bool

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                isExpanded.toggle()
            }
        }) {
            image()
        }
    }
    
    func image() -> Image {
        
        let imageName = isExpanded ? "chevron.down" : "chevron.up"
        
        return Image(systemName: imageName)
    }
}


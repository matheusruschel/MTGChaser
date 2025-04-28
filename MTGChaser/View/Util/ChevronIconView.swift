//
//  ChevronButton.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI

struct ChevronIconView: View {
    
    var isExpanded: Bool

    var body: some View {
        image()
    }
    
    func image() -> Image {
        
        let imageName = isExpanded ? "chevron.down" : "chevron.up"
        
        return Image(systemName: imageName)
    }
}


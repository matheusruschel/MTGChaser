//
//  ReversibleCardView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReversibleCardView: View {
    
    @State
    var card: Card
    
    @State
    var showBack: Bool = false
    @State
    var shouldRotate : Bool = false
    
    var body: some View {
        
        if let frontUrl = card.card_faces?.first?.image_uris?.normal,
           let backUrl = card.card_faces?.last?.image_uris?.normal {
            
            ZStack {
                if showBack {
                    WebImage(url: backUrl)
                        .resizable()
                        .scaledToFit()
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                } else {
                    WebImage(url: frontUrl)
                        .resizable()
                        .scaledToFit()
                }
            }
            .rotation3DEffect(shouldRotate ? Angle(degrees: 180) : .zero, axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: shouldRotate)
            .overlay {
                GeometryReader { geometry in
                            Button(action: {
                                shouldRotate.toggle()
                                
                                Task {
                                    try await Task.sleep(until: .now + .seconds(0.1))
                                    
                                    Task { @MainActor in
                                        showBack.toggle()
                                    }
                                }

                            }) {
                                Image("icons8-flip_small")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(geometry.size.width * 0.02) // padding to center the image inside the circle
                            }
                            .frame(width: geometry.size.width * 0.18, height: geometry.size.width * 0.18)
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                            .position(x: geometry.size.width * 0.8,
                                      y: geometry.size.height * 0.35)
                            
                }
            }
            
        } else {
            Text("Card \(card.name) is \(card.layout)")
        }
        

    }
}

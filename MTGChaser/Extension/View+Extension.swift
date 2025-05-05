//
//  Placeholder.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-05.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        withGradient: [Color],
        alignment: Alignment = .leading) -> some View {
            
            placeholder(when: shouldShow, alignment: alignment) {
                Text(text)
                    .foregroundStyle(
                        .linearGradient(
                            colors: withGradient,
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
            }
        }
}

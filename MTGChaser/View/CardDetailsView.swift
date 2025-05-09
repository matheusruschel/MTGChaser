//
//  CardDetailsView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-09.
//

import SwiftUI

struct CardDetailsView: View {
    
    @EnvironmentObject var settings: Settings
    
    var card: Card
    
    // Format price with currency symbol
    private func formatPrice(_ finish: Finishes) -> String {
        
        switch finish {
        case .foil:
            if let price = card.prices?.usd_foil {
                return "$\(price)"
            }
        case .nonfoil:
            if let price = card.prices?.usd {
                return "$\(price)"
            }
        }
        
        return "N/A"
    }
    
    // Return color based on card rarity
    private func rarityColor(_ rarity: Rarity?) -> Color {
        guard let rarity = rarity else { return .gray }
        
        switch rarity {
        case .common:
            return .gray
        case .uncommon:
            return .blue
        case .rare:
            return .yellow
        case .mythic:
            return .orange
        }
    }
    
    @ViewBuilder
    private func priceCircle(for finish: Finishes, size: CGFloat) -> some View {
        if finish == .foil {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: size, height: size)
                .foregroundStyle(
                    LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.6),
                                    Color.blue.opacity(0.7),
                                    Color.purple.opacity(0.8),
                                    Color.cyan,
                                    Color.pink
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
        } else {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(.appTertiary)
        }
    }
    
    var body: some View {
        
        VStack {
            switch settings.displayMode {
            case 0:
                HStack(spacing: 10) {
                    if card.finishes.contains(.nonfoil) {
                        HStack(spacing: 4) {
                            priceCircle(for: .nonfoil, size: 23)
                            
                            Text(formatPrice(.nonfoil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                    
                    if card.finishes.contains(.foil) {
                        HStack(spacing: 4) {
                            priceCircle(for: .foil, size: 23)
                            
                            Text(formatPrice(.foil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                }
                
            case 1:
                HStack {
                    if card.finishes.contains(.nonfoil) {
                        HStack(spacing: 4) {
                            priceCircle(for: .nonfoil, size: 15)
                            
                            Text(formatPrice(.nonfoil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    
                    if card.finishes.contains(.foil) {
                        HStack(spacing: 4) {
                            priceCircle(for: .foil, size: 15)
                            
                            Text(formatPrice(.foil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                }
            case 2:
                VStack(spacing: 2) {
                    if card.finishes.contains(.nonfoil) {
                        HStack(spacing: 2) {
                            priceCircle(for: .nonfoil, size: 10)
                            
                            Text(formatPrice(.nonfoil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 11, weight: .semibold))
                            Spacer()
                        }
                    }
                    
                    if card.finishes.contains(.foil) {
                        HStack(spacing: 2) {
                            priceCircle(for: .foil, size: 10)
                            
                            Text(formatPrice(.foil))
                                .foregroundColor(.appTertiary)
                                .font(.system(size: 11, weight: .semibold))
                            Spacer()
                        }
                    }
                }
            default:
                VStack {
                    Text("No finishes available")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
    }
}

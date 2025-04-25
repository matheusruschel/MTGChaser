//
//  Card.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

struct Card: Decodable, Identifiable {
    var id: String
    var name: String
    var description: String?
    var image_uris: ImageUri?
    var prices: Prices?
    var rarity: Rarity
}

struct ImageUri: Decodable {
    var small: URL
    var normal: URL
    var large: URL
    var png: URL
    var art_crop: URL
    var border_crop: URL
}

struct Prices: Decodable {
    var usd: String?
}

enum Rarity: Decodable, Hashable, Equatable {
    case mythic
    case rare
    case uncommon
    case common
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "mythic":
            self = .mythic
        case "rare":
            self = .rare
        case "uncommon":
            self = .uncommon
        default:
            self = .common
        }
    }
    
    static func > (lhs: Rarity, rhs: Rarity) -> Bool {
        switch (lhs, rhs) {
        case (.mythic, _):
            return true
        case (.rare, .uncommon):
            return true
        case (.rare, .common):
            return true
        case (.uncommon, .common):
            return true
        default:
            return false
        }
    }
}


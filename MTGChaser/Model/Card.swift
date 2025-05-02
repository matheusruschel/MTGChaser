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
    var layout: CardLayout
    var card_faces: [CardFace]?
    var finishes: [Finishes]
}

struct CardFace: Decodable {
    var image_uris: ImageUri?
}

enum Finishes: Decodable, Hashable, Equatable {
    case nonfoil
    case foil
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "nonfoil":
            self = .nonfoil
        case "foil":
            self = .foil
        default :
            self = .foil
        }
    }
}

enum CardLayout: Decodable, Hashable, Equatable {
    case normal
    case reversible_card
    case notSupported
    case prototype
    case transform
    case adventure
    case saga
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "normal":
            self = .normal
        case "reversible_card":
            self = .reversible_card
        case "prototype":
            self = .prototype
        case "transform":
            self = .transform
        case "adventure":
            self = .adventure
        case "saga":
            self = .saga
        default:
            self = .notSupported
        }
    }
    
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


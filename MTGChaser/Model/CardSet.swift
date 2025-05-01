//
//  Set.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

struct CardSet: Decodable, Hashable, Identifiable {
    var id: String
    var code: String
    var released_at: String
    var set_type: SetType
    var name: String
    var icon_svg_uri: String
    var search_uri: String
    var card_count: Int
    
    static func ==(lhs: CardSet, rhs: CardSet) -> Bool {
        return lhs.id == rhs.id
    }
}

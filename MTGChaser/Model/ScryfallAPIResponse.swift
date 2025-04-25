//
//  ScryfallReturnObject.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-09.
//


import Foundation

struct ScryfallAPIResponse<T: Decodable & Sendable>: Decodable {
    var has_more: Bool?
    var object: String
    var total_cards: Int?
    var next_page: String?
    var data: [T]?
}

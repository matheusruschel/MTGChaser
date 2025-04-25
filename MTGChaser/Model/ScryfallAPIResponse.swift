//
//  ScryfallReturnObject.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-09.
//


import Foundation

struct ScryfallAPIResponse<T: Decodable>: Decodable {
    var has_more: Bool
    var object: String
    var data: [T]
}

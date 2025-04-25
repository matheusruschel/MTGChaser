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
    var description: String
    var image: URL
}

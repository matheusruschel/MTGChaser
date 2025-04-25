//
//  SetType.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-09.
//

enum SetType: Decodable, Hashable {
    case expansion
    case token
    case notSupported(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "expansion":
            self = .expansion
        case "token":
            self = .token
        default:
            self = .notSupported(rawValue)
        }
    }
}

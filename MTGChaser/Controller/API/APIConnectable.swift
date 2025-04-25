//
//  APIConnectable.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//

import Foundation

protocol APIConnectable: Sendable {
    func get(url: URL) async throws -> Data
}

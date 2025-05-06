//
//  Settings.swift
//  MTGChaser
//
//  Created by Bruna on 2025-05-06.
//

import Foundation
import Combine

@MainActor
class Settings: ObservableObject {
    
    init() {
        displayMode = Settings.displayMode()
    }
    
    @Published
    var displayMode: Int = 0 {
        didSet {
            setDisplayMode(displayMode)
        }
    }
    
    private static func displayMode() -> Int {
        return UserDefaults.standard.integer(forKey: "displayMode")
    }
    
    private func setDisplayMode(_ mode: Int) {
        UserDefaults.standard.set(mode, forKey: "displayMode")
    }
    
}

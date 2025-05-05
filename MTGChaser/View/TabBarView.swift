//
//  TabBar.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-07.
//
import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "app.secondary")
    }
    
    var body: some View {
        TabView {
            SpoilerView()
                .tabItem {
                    Label("Spoilers", systemImage: "list.dash")
                }
            
            ChaseView()
                .tabItem {
                    Label("Chase", systemImage: "square.and.pencil")
                }
        }
        .accentColor(.appEmerald)
    }
}

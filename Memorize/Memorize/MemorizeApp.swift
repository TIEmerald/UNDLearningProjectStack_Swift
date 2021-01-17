//
//  MemorizeApp.swift
//  Memorize
//
//  Created by UNDaniel on 10/1/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup<ContentView> {
            ContentView(viewModel: game)
        }
    }
}

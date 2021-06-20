//
//  EmojiArtProjectApp.swift
//  EmojiArtProject
//
//  Created by UNDaniel on 7/4/21.
//

import SwiftUI

@main
struct EmojiArtProjectApp: App {
    
    let store = EmojiArtDocumentStore(named: "Emoji Art")
    
    init() {
    }
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentChooser().environmentObject(store)
        }
    }
}

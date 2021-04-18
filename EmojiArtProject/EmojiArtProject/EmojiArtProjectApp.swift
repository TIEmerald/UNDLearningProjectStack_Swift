//
//  EmojiArtProjectApp.swift
//  EmojiArtProject
//
//  Created by UNDaniel on 7/4/21.
//

import SwiftUI

@main
struct EmojiArtProjectApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}

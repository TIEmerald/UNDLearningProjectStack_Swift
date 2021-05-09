//
//  OptionalImage.swift
//  EmojiArtProject
//
//  Created by UNDaniel on 9/5/21.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}

//
//  ContentView.swift
//  Memorize
//
//  Created by UNDaniel on 10/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return HStack(content: {
            ForEach(0..<4, content: { _ in
                CardView()
            })
        })
            .foregroundColor(Color.orange)
            .padding()
            .font(Font.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var isFaceUp = true
    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        })
    }
}

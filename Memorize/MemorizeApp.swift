//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ben Essex and Paul Hegarty on 29 May 22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}

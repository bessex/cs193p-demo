//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ben Essex and Paul Haggerty on 03 Jun 22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let themes = [
        Theme(name: "travel", elements: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🛻", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚠", "🚃", "🚄", "🚂", "✈️", "🚀", "🛸", "🚁", "🛶", "⛵️", "🚤", "🚢"], numberOfPairs: 15, color: "red"),
        Theme(name: "flags", elements: ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩"], numberOfPairs: 10, color: "blue"),
        Theme(name: "sports", elements: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🛝", "🏹", "🎣", "🤿", "🥊"], numberOfPairs: 5, color: "pink"),
        Theme(name: "jobs", elements: ["👮‍♀️", "👷‍♂️", "💂‍♀️", "🕵️‍♂️", "👩‍⚕️", "🧑‍🌾", "🧑‍🍳", "👨‍🎤", "👨‍🏫", "👩‍🏭"], numberOfPairs: 10, color: "mint"),
        Theme (name: "animals", elements: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨"], numberOfPairs: 10, color: "indigo"),
        Theme(name: "food", elements: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"], numberOfPairs: 10, color: "orange")]
    
    static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: min(theme.elements.count, theme.numberOfPairs)) { pairIndex in
            theme.elements[pairIndex]
        }
    }
    
    private var theme: Theme<String>
    
    // @Published-->anytime model changes, objectWillChange.send() is called
    @Published private var model: MemoryGame<String>
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var cardColor: String {
        theme.color
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        theme.name
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}

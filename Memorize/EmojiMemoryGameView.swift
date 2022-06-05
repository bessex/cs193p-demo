//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ben Essex and Paul Haggerty on 29 May 22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Tells View to redraw whenever ViewModel publishes changes
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize \(game.themeName)!")
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65.0))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card, cardColor: gameColor(from: game.cardColor))
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
            }
            
            Spacer()
            
            HStack {
                Text("Score: \(game.score)")
                Spacer()
                newGame
            }
            .font(.largeTitle)
            
        }
        .padding(.horizontal)
    }
    
    private var newGame: some View {
        Button {
            game.startNewGame()
        } label: {
            VStack {
                Image(systemName: "plus")
                
                Text("New Game")
                    .font(.subheadline)
            }
        }
    }
    
    private func gameColor(from colorString: String) -> Color {
        switch colorString {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .gray
        case "indigo":
            return .indigo
        case "mint":
            return .mint
        case "orange":
            return .orange
        case "pink":
            return .pink
        default:
            return .white
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let cardColor: Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(cardColor)
            }
        }
    }
}

































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}

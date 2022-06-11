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
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card, cardColor: gameColor(from: game.cardColor))
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
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
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(cardColor)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill().foregroundColor(cardColor)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
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

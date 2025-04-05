//
//  CardView.swift
//  memoryGame
//
//  Created by Lisa Jo on 4/2/25.
//

import SwiftUI

struct CardView: View {
    typealias CardModel = MemoryGameModel<String>.CardModel
    let action: () -> Void
    let card: CardModel
    
    init(action: @escaping() -> Void, card: CardModel) {
        self.action = action
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(card.isFaceUp ? 0.3 : 0)
            .overlay(content: {
                Text(card.content)
                    .font(Font.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(10)
                    .opacity(card.isFaceUp ? 1 : 0)

            })
            .padding(10)
            .modifier(Cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched))
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
            .onTapGesture {
                action()
            }
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.CardModel
    static let viewModel = MemoryGameViewModel()
    
    static var previews: some View {
        HStack {
            CardView(action: {}, card: Card(id: "1", isFaceUp: true, content: "❤️"))
            CardView(action: {}, card: Card(id: "2", isFaceUp: false, content: "X"))
        }
    }
}


struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isMatched: Bool

    func body(content: Content) -> some View {
        let base =  RoundedRectangle(cornerRadius: 10, style: .circular)
        
        ZStack {
            base
                .fill(isFaceUp ? .white : .indigo)
                .stroke(isFaceUp ? .purple : .black, lineWidth: 3)
            content
        }
        .aspectRatio(2/3, contentMode: .fit)
        .padding(5)
    }
}

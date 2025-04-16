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
    let score: Int
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    private func scoreChange(causedBy card: CardModel) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 02
    }
    
    init(action: @escaping() -> Void, card: CardModel, score: Int) {
        self.action = action
        self.card = card
        self.score = score
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(card.isFaceUp ? 0.3 : 0)
            .overlay(content: {
                cardContents
            })
            .padding(10)
            .modifier(Cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched))
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
            .rotation3DEffect(.degrees(card.isFaceUp ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation {
                    let priorScore = score
                    action()
                    let scoreChange = priorScore - self.score
                    lastScoreChange = (scoreChange, causedByCardID: card.id)
                }
            }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(Font.system(size: 200))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fit)
            .padding(10)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
            .opacity(card.isFaceUp ? 1 : 0)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.CardModel
    static let viewModel = MemoryGameViewModel()
    
    static var previews: some View {
        HStack {
            CardView(action: {}, card: Card(id: "1", isFaceUp: true, isMatched: true, content: "❤️"), score: 2)
            CardView(action: {}, card: Card(id: "2", isFaceUp: false, content: "X"), score: 3)
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

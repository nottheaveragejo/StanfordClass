//
//  CardView.swift
//  memoryGame
//
//  Created by Lisa Jo on 4/2/25.
//

import SwiftUI

struct CardView: View {
    typealias CardModel = MemoryGameModel<String>.CardModel
    let card: CardModel
    @ObservedObject private var viewModel: MemoryGameViewModel
    
    init(viewModel: MemoryGameViewModel, card: CardModel) {
        self.viewModel = viewModel
        self.card = card
    }
    var body: some View {
        let base =  RoundedRectangle(cornerRadius: 10, style: .circular)
        VStack {
            base.fill(card.isFaceUp ? Color.white : Color.black)
                .overlay(content: {
                    ZStack {
                        base.fill(card.isFaceUp ? Color.white : Color.indigo)
                        base.stroke(card.isFaceUp ? .purple : .black, lineWidth: 3)
                        Text(card.isFaceUp ? card.content : "")
                            .font(Font.system(size: 60))
                    }
                })
                .aspectRatio(2/3, contentMode: .fit)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        .padding(.bottom, 10)
        .onTapGesture {
            viewModel.handleCardWasTapped(cardID: card.id)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.CardModel
    static let viewModel = MemoryGameViewModel()
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(viewModel: viewModel, card: Card(id: "1", isFaceUp: true, content: "A"))
                CardView(viewModel: viewModel, card: Card(id: "2", isFaceUp: false, content: "A"))
            }
            HStack {
                CardView(viewModel: viewModel, card: Card(id: "1", isMatched: true, content: "A"))
                CardView(viewModel: viewModel, card: Card(id: "1", isMatched: false, content: "A"))
            }
        }

    }
}

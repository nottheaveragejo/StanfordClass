//
//  ContentView.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/18/25.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject private var viewModel: MemoryGameViewModel
    
    init(viewModel: MemoryGameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            cardsView
            themeButtons
            numberOfCardsView
            Text("Score \(viewModel.score)")
            Button {
                viewModel.shuffle()
            } label: {
                Text("shuffle")
                    .font(Font.system(size: 40))
            }
        }
        .padding()
    }
    
    private var themeButtons: some View {
        VStack {
            Text("Change Theme")
            HStack {
                Button {
                    viewModel.changeCardTheme()
                } label: {
                    VStack {
                        Text("🌍")
                            .font(Font.system(size: 40))
                        Text("Choose a theme")
                    }
                }
            }
        }
    }
    
    private var numberOfCardsView: some View {
        return VStack {
            Text("Number of Pairs of Cards:\(viewModel.numberOfPairsOfCards)")
            HStack {
                Button {
                    viewModel.updateNumberOfCards(shouldAdd: false)
                } label: {
                    Image(systemName: "rectangle.stack.badge.minus")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button {
                    viewModel.updateNumberOfCards()
                } label: {
                    Image(systemName: "rectangle.stack.badge.plus")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
    private var cardsView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach($viewModel.cardModels.indices, id: \.self) { card in
                    CardView(viewModel: viewModel, card: viewModel.cardModels[card])
                }
            }
            .padding(.horizontal)
        }
    }
    
    private struct CardView: View {
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
                base.fill(card.isMatched ? Color.white : Color.black)
                    .opacity(card.isMatched ? 1 : 0)
                    .overlay(content: {
                        ZStack {
                            base.fill(card.isFaceUp ? Color.white :  Color.indigo)
                            base.stroke(card.isFaceUp ? .purple : .black, lineWidth: 3)
                            Text(card.isFaceUp ? card.content : "")
                                .font(Font.system(size: 60))
                        }
                        .opacity(card.isMatched ? 0 : 1)
                    }
                    )
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .padding(.bottom, 10)
            .onTapGesture {
                viewModel.handleCardWasTapped(cardID: card.id)
            }
        }
    }
}


#Preview {
    let viewModel = MemoryGameViewModel()
    MemoryGameView(viewModel: viewModel)
}

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
            controlButtons
            numberOfCardsView
            Text("Score \(viewModel.score)")
                .font(.headline)
        }
        .padding()
    }
    
    private var controlButtons: some View {
        HStack {
            Button {
                viewModel.changeCardTheme()
            } label: {
                VStack {
                    Text("🌍")
                        .font(Font.system(size: 40))
                    Text("Current theme: \(viewModel.themeName)")
                }
            }
            
            Button {
                viewModel.shuffle()
            } label: {
                VStack {
                    Text("🃗")
                        .font(Font.system(size: 40))
                    Text("shuffle")
                }
            }
        }
    }
    
    private var numberOfCardsView: some View {
        return VStack {
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
            Text("Number of Pairs of Cards:\(viewModel.numberOfPairsOfCards)")
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
}


#Preview {
    let viewModel = MemoryGameViewModel()
    MemoryGameView(viewModel: viewModel)
}

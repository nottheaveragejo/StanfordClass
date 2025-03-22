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
                    viewModel.theme = .japanese
                    viewModel.updateCards()
                } label: {
                    Text("🇯🇵")
                        .font(Font.system(size: 40))
                }
                Button {
                    viewModel.theme = .british
                    viewModel.updateCards()
                } label: {
                    Text("🇬🇧")
                        .font(Font.system(size: 40))
                }
                Button {
                    viewModel.theme = .french
                    viewModel.updateCards()
                } label: {
                    Text("🇫🇷")
                        .font(Font.system(size: 40))
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
                ZStack {
                    base.fill(!card.isFaceUp ? Color.white :  Color.black)
                    base.stroke(!card.isFaceUp ? .black : .blue, lineWidth: 2)
                    Text(card.content)
                        .font(Font.system(size: 60))
                    
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
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

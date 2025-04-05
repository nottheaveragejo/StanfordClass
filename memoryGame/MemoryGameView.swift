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
            Text("Current theme: \(viewModel.themeName)")
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
                    Text("Change theme")
                }
            }
            .padding(.trailing, 20)
            
            Button {
                withAnimation {
                    viewModel.shuffle()
                }
            } label: {
                VStack {
                    Text("🃗")
                        .font(Font.system(size: 40))
                    Text("shuffle")
                }
            }
            .padding(.leading, 20)
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
                    CardView(action: { viewModel.handleCardWasTapped(cardID: viewModel.cardModels[card].id) } , card: viewModel.cardModels[card])
                        }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    let viewModel = MemoryGameViewModel()
    MemoryGameView(viewModel: viewModel)
}

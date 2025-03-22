//
//  ContentView.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/18/25.
//

import SwiftUI

struct MemoryGameView: View {
    @StateObject private var viewModel = MemoryGameViewModel()
    var body: some View {
        VStack {
            cardsView
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    var cardsView: some View {
        ScrollView {
            ForEach(viewModel.cardModels.indices, id: \.self) { card in
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                    CardView(card: viewModel.cardModels[card])
                }
            }
        }
    }
    
    
    private struct CardView: View {
        let card: MemoryGameModel<String>.CardModel
        
        init(card: MemoryGameModel<String>.CardModel) {
            self.card = card
        }
        var body: some View { ZStack {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .border(.cyan)
            Text(card.content)
                .font(Font.custom("MyFont", size: 62, relativeTo: .title))

        }
        .aspectRatio(2/3, contentMode: .fit)
        }
    }
}


#Preview {
    MemoryGameView()
}

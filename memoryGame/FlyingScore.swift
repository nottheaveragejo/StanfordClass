//
//  FlyingScore.swift
//  memoryGame
//
//  Created by Lisa Jo on 4/9/25.
//

import SwiftUI

struct FlyingScore: View {
    typealias CardModel = MemoryGameModel<String>.CardModel
    
    var model: CardModel
    
    var body: some View {
        Text(model.isMatched ? "+3" : "-2")
            .font(.title)
            .foregroundColor(model.isMatched ? .green : .red)
            .shadow(radius: 3)
            .offset(x: 0, y: model.isMatched ? -20 : 0)
            .opacity(model.isFaceUp ? 1 : 0)
    }
}

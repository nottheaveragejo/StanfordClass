//
//  MemoryGameModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/18/25.
//

import Foundation
import SwiftUICore

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private var singleCardSelectedIndex: Int? = nil
    var cardModels: [CardModel] = []
    private var cardsContent: [CardContent]
    private var numberOfPairsOfCards: Int

    // choose a card logic
    // TODO: check if any card is selected
    // TODO: if no card is selected, set singleCardSelectedIndex to value
    // TODO: is a card is selected, check content of that selected card to singleCardSelectedIndex,
    // if it matches, set isFaceUp and isMatched to true
    // if not matched, turn card back around
    mutating func chooseACard(at cardID: String) {
        let index = self.cardModels.firstIndex(where: { $0.id == cardID})
        self.cardModels[index!].isFaceUp.toggle()
        print("test 1 \(self.cardModels[index!].isFaceUp)")

    }
    
    init(cardsContent: [CardContent], numberOfPairsOfCards: Int) {
        self.cardsContent = cardsContent
        self.numberOfPairsOfCards = numberOfPairsOfCards
        createCardModels()
    }

    mutating func updatePairsOfCards(cards numberOfPairsOfCards : Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
    
    mutating func updateCardContent(themeContent: [String]) {
        for index in self.cardModels.indices {
            if index % 2 == 0 {
                let themeIndex = index/2
                self.cardModels[index].content = themeContent[themeIndex] as! CardContent
            }
            else {
                let themeIndex = (index - 1 )/2
                self.cardModels[index].content = themeContent[themeIndex] as! CardContent
            }
        }
    }

    mutating func createCardModels() {
        var updatedCardModels = cardModels
        self.cardsContent.forEach { cardContent in
            updatedCardModels.append(CardModel(id:"\(cardContent.self)1", content: cardContent.self))
            updatedCardModels.append(CardModel(id:"\(cardContent.self)2", content: cardContent.self))
        }
        cardModels = updatedCardModels
    }
    
    mutating func shuffle() {
        cardModels.shuffle()

    }
    
    struct CardModel: Identifiable,Equatable {
        var id: String
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        init(id: String, content: CardContent) {
            self.id = id
            self.content = content
        }
    }
    
}


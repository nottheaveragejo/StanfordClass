//
//  MemoryGameModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/18/25.
//

import Foundation

struct MemoryGameModel<CardContent> {
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
    func chooseACard(at index: Int) {
        
    }
    
    init(cardsContent: [CardContent], numberOfPairsOfCards: Int) {
        self.cardsContent = cardsContent
        self.numberOfPairsOfCards = numberOfPairsOfCards
        createCardModels()
    }
    
    mutating func createCardModels() {
        var updatedCardModels = cardModels
        self.cardsContent.forEach { cardContent in
            updatedCardModels.append(CardModel(content: cardContent.self))
            updatedCardModels.append(CardModel(content: cardContent.self))
        }
        cardModels = updatedCardModels
    }
    
    mutating func shuffle() {
        cardModels.shuffle()
    }
    
    struct CardModel {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        
        init(content: CardContent) {
            self.content = content
        }
    }
    
}


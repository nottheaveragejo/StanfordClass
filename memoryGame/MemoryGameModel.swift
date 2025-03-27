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
    private var secondCardSelectedIndex: Int? = nil
    var cardModels: [CardModel] = []
    private var cardsContent: [CardContent]
    private var numberOfPairsOfCards: Int
    var score: Int = 0
    
    init(cardsContent: [CardContent], numberOfPairsOfCards: Int) {
        self.cardsContent = cardsContent
        self.numberOfPairsOfCards = numberOfPairsOfCards
        createCardModels()
    }
    
    // TODO: delay logic to flip card over when the cards dont match
    mutating func chooseACard(at cardID: String) {
        let index = self.cardModels.firstIndex(where: { $0.id == cardID})
        if singleCardSelectedIndex == nil {
            singleCardSelectedIndex = index
            self.cardModels[index!].isFaceUp = true
        } else {
            let potentialMatch = self.cardModels[index!]
            let previousCard = self.cardModels[singleCardSelectedIndex!]
            self.cardModels[index!].isFaceUp = true
            if potentialMatch.content == previousCard.content {
                self.cardModels[index!].isMatched = true
                self.cardModels[singleCardSelectedIndex!].isMatched = true
                singleCardSelectedIndex = nil
                score += 2
            } else {
                self.cardModels[singleCardSelectedIndex!].isFaceUp = false
                singleCardSelectedIndex = index
                score -= 1
            }
        }
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


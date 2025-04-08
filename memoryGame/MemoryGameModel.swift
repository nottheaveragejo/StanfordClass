//
//  MemoryGameModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/18/25.
//

import Foundation
import SwiftUICore

struct MemoryGameModel<CardContent> where CardContent: Equatable {
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
    
    private var singleCardSelectedIndex: Int? {
        get {
            let faceUpIndices = cardModels.indices.filter { index in cardModels[index].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
        }
        set {
            cardModels.indices.forEach { cardModels[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    mutating func chooseACard(at cardID: String) {
        if let index = self.cardModels.firstIndex(where: { $0.id == cardID}) {
            print("cardModels[index] \(cardModels[index].id) cardID \(cardID)")
            if !cardModels[index].isFaceUp && !cardModels[index].isMatched {
                if let potentialMatchIndex = singleCardSelectedIndex {
                    if cardModels[index].content == cardModels[potentialMatchIndex].content {
                        cardModels[index].isMatched = true
                        cardModels[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cardModels[index].hasUserSeenCard {
                            score -= 1
                        }
                    }
                } else {
                    for index in cardModels.indices {
                        cardModels[index].isFaceUp = false
                    }
                    singleCardSelectedIndex = index
                    cardModels[index].hasUserSeenCard = true

                }
                cardModels[index].isFaceUp = true
            }
        }
    }
    
    mutating func updatePairsOfCards(cards numberOfPairsOfCards : Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        createCardModels(numberOfPairsOFCards: self.numberOfPairsOfCards)
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
    
    mutating func createCardModels(numberOfPairsOFCards: Int = 5) {
        var updatedCardModels: [CardModel] = []
        if self.numberOfPairsOfCards == 0 {
            cardModels = []
            return
        }
        for index in 0...self.numberOfPairsOfCards - 1 {
            let cardContent = cardsContent[index]
            updatedCardModels.append(CardModel(id:"\(cardContent)1", content: cardContent))
            updatedCardModels.append(CardModel(id:"\(cardContent)2", content: cardContent))
        }
        cardModels = updatedCardModels
    }
    
    mutating func shuffle() {
        let updatedCards = cardModels.shuffled()
        print("before \(cardModels)")
        cardModels = []
        cardModels = updatedCards
        let newCardContent = cardModels.map(\.content)
        print("after \(cardModels)")
        cardsContent = newCardContent
    }
    
    struct CardModel: Identifiable, Equatable {
        var id: String
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasUserSeenCard = true
                }
            }
        }
        var isMatched: Bool
        var hasUserSeenCard = false
        var content: CardContent
        
        init(id: String, isFaceUp: Bool = false, isMatched: Bool = false, content: CardContent) {
            self.id = id
            self.isFaceUp = isFaceUp
            self.isMatched = isMatched
            self.content = content
        }
    }
}


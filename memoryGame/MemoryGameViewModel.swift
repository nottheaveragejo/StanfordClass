//
//  MemoryGameViewModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/21/25.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    typealias CardModel = MemoryGameModel<String>.CardModel
    private var model: MemoryGameModel<String>
    
    @Published var theme: Theme
    @Published var numberOfPairsOfCards = 5
    @Published var cardModels: [CardModel]
    @Published var score = 0

    init() {
        self.theme = .japanese
        self.model = MemoryGameModel(cardsContent: Theme.japanese.content, numberOfPairsOfCards: 5)
        cardModels =  model.cardModels
        self.score = model.score
    }
    
    func shuffle() {
        model.shuffle()
        cardModels =  model.cardModels
    }
    
    func updateCards() {
        model.updateCardContent(themeContent: theme.content)
        cardModels =  model.cardModels
    }
    
    func updateNumberOfCards(shouldAdd: Bool = true) {
        let currentNumberOfPairOfCards = cardModels.count / 2
        if shouldAdd && numberOfPairsOfCards < currentNumberOfPairOfCards {
            numberOfPairsOfCards += 1
            self.model.updatePairsOfCards(cards: numberOfPairsOfCards)
        } else if !shouldAdd && numberOfPairsOfCards > 0 {
            numberOfPairsOfCards -= 1
            self.model.updatePairsOfCards(cards: numberOfPairsOfCards)
        } else {
            return
        }
    }
    
    func handleCardWasTapped(cardID: String) {
        model.chooseACard(at: cardID)
        cardModels = model.cardModels
        score = model.score
    }
    
    enum Theme: CaseIterable {
        case japanese
        case french
        case british
        
        var content: [String] {
            switch self {
            case .japanese:
                ["💴", "🍡", "🍱", "🍣", "🍙", "🎑", "🥟", "👘"]
            case .french:
                ["🇫🇷", "🥖", "🧑‍🎨", "🍷", "👗", "👩🏼‍🎨", "🐌", "🍇"]
            case .british:
                ["🍤", "🇬🇧", "🐑", "🍟", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🍫", "🫖"]
            }
        }
    }
}

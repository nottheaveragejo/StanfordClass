//
//  MemoryGameViewModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/21/25.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    typealias CardModel = MemoryGameModel<String>.CardModel
    // Store current theme
    @Published var theme: Theme
    private var model: MemoryGameModel<String>
    @Published var numberOfPairsOfCards = 5
    @Published var cardModels: [CardModel]

    init() {
        self.theme = .japanese
        self.model = MemoryGameModel(cardsContent: Theme.japanese.content, numberOfPairsOfCards: 5)
        cardModels =  model.cardModels
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

//
//  MemoryGameViewModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/21/25.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    // Store current theme
    @Published var defaultTheme: Theme = .japanese
    private var model: MemoryGameModel<String>
    private let numberOfPairsOfCards = 5
    let cardModels: [MemoryGameModel<String>.CardModel]
    init() {
        self.model = MemoryGameModel(cardsContent: Theme.japanese.content, numberOfPairsOfCards: numberOfPairsOfCards)
        cardModels =  model.cardModels
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    enum Theme: CaseIterable {
        case japanese
        case french
        case british
        
        var content: [String] {
            switch self {
            case .japanese:
                ["💴", "🍡", "🍱", "🍣", "🍙", "🎑"]
            case .french:
                ["🇫🇷", "🥖", "🧑‍🎨", "🍷", "👗", "👩🏼‍🎨"]
            case .british:
                ["🍤", "🇬🇧", "🐑", "🍟", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"]
            }
        }
    }
    
    
}

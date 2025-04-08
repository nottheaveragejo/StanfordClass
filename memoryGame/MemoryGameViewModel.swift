//
//  MemoryGameViewModel.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/21/25.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    typealias CardModel = MemoryGameModel<String>.CardModel
    @Published private var model: MemoryGameModel<String> {
        willSet {
            cardModels = model.cardModels
        }
    }
    
    @Published var theme: Theme
    @Published var themeName: String
    @Published var numberOfPairsOfCards: Int
    @Published var cardModels: [CardModel]
    @Published var score = 0

    init() {
        self.theme = .japanese
        self.themeName = Theme.japanese.name
        self.model = MemoryGameModel(cardsContent: Theme.japanese.content, numberOfPairsOfCards: 5)
        cardModels = MemoryGameModel(cardsContent: Theme.japanese.content, numberOfPairsOfCards: 5).cardModels
        self.numberOfPairsOfCards = 5
        self.score = model.score
    }
    
    func shuffle() {
        model.shuffle()
       cardModels = model.cardModels
    }
    
    func changeCardTheme() {
        theme = Theme.allCases.randomElement() ?? .thailand
        themeName = theme.name
        model.updateCardContent(themeContent: theme.content)
        cardModels = model.cardModels
    }
    
    func updateNumberOfCards(shouldAdd: Bool = true) {
        if shouldAdd && numberOfPairsOfCards < Theme.japanese.content.count  {
            numberOfPairsOfCards += 1
        } else if !shouldAdd && numberOfPairsOfCards > 0 {
            numberOfPairsOfCards -= 1
        } else {
            return
        }
        self.model.updatePairsOfCards(cards: numberOfPairsOfCards)
        cardModels = model.cardModels
    }
    
    func handleCardWasTapped(cardID: String) {
        model.chooseACard(at: cardID)
       // cardModels = model.cardModels
        score = model.score
    }
    
    enum Theme: CaseIterable {
        case japanese
        case french
        case british
        case peru
        case american
        case thailand
        case italy
        case vietnam
        
        var name: String {
            switch self {
            case .japanese:
                "japanese"
            case .french:
                "french"
            case .british:
                "british"
            case .peru:
                "peru"
            case .american:
                "american"
            case .thailand:
                "thailand"
            case .italy:
                "italy"
            case .vietnam:
                "vietnam"
            }
        }
        
        var content: [String] {
            switch self {
            case .japanese:
                ["💴", "🍡", "🍱", "🍣", "🍙", "🎑", "🥟", "👘"]
            case .french:
                ["🇫🇷", "🥖", "🧑‍🎨", "🍷", "👗", "👩🏼‍🎨", "🐌", "🍇"]
            case .british:
                ["🍤", "🇬🇧", "🐑", "🍟", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🍫", "🫖"]
            case .peru:
                ["⛰️", "🦙", "🥾", "🏕️", "🇵🇪", "🍲", "🐒", "🌿"]
            case .american:
                ["🇺🇸", "🔫", "🍔", "⚠", "🥃", "🌽", "🙈", "🌭"]
            case .thailand:
                ["🐘", "🦛", "🏖️", "🥥", "🇹🇭", "🥤", "🛕", "🐷"]
            case .italy:
                ["🇮🇹", "🍕", "🍝", "☕️", "⛪️", "🍷", "🐰", "🌿"]
            case .vietnam:
                ["🇻🇳", "🍜", "🏍️", "☕️", "🥝", "🌄", "🚢", "🌸"]
            }
        }
    }
}

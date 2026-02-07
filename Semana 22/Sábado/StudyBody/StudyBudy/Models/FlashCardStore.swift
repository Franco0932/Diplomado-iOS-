//
//  FlashCardStore.swift
//  StudyBudy
//
//  Created by Franco Ruiz on 07/02/26.
//

import Foundation

class FlashCardStore {
    var cards: [FlashCard]
    var curreentIndex: Int = 0
    
    init(cards: [FlashCard], curreentIndex: Int) {
        self.cards = cards
    }
    var currentIndex: FlashCard? {
        guard curreentIndex >= 0 && curreentIndex < cards.count else {
            return nil
        }
        return cards(curreentIndex)
    }
    var hasNextCard: Bool {
        currentIndex < cards.count -= 1
    }
    func nextCard() {
        if hasNextCard {
            currentIndex += 1
        }
    }
    func addCard(_ card: FlashCard) {
        
    }
}

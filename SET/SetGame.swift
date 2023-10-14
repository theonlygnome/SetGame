//
//  SwiftUIView.swift
//  SET
//
//  Created by Naomi Anderson on 10/5/23.
//

import SwiftUI

class SetGame: ObservableObject {
    typealias Card = SetCard.Card
    @Published private var model = SetCard()
    
    var cards: Array<Card> {
        model.dealtCards
    }
    
    var undealtCards: Array<Card> {
        model.undealtCards
    }
    
    var discardedCards: Array<Card> {
        model.discardedCards
    }
    
    var matchedSetExists: Bool {
        model.matchedSetExists
    }
    
    func newGame() {
        model = SetCard()
        deal()
        deal()
        deal()
        deal()
    }
    
    func getCardsToDeal() -> [Card] {
        model.getCardsToDeal()
    }
    
    func dealCard(_ card: Card) {
        model.dealCard(card)
    }
    
    func deal() {
        model.deal()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}


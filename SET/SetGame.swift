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
    
    func newGame() {
        model = SetCard()
        deal()
        deal()
        deal()
        deal()
    }
    
    func deal() {
        model.deal()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
        
    func getShapeFromString(_ shapeString: String) -> any Shape {
        
        switch shapeString {
        case "Diamond":
            return Diamond()
        case "Oval":
            return RoundedRectangle(cornerRadius: 25)
        case "Squiggle":
            return Rectangle()
        default:
            return Circle() // This is an error
        }
    }
}


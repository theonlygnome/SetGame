//
//  Model.swift
//  SET
//
//  Created by Naomi Anderson on 10/4/23.
//

import Foundation
import SwiftUI

import Foundation

struct SetCard {
    private(set) var cards: Array<Card>
    private(set) var dealtCards: Array<Card>
    
    var matchedSetExists: Bool {
        // A matched set exists
        dealtCards.filter { $0.isMatched }.count == 3 &&
        dealtCards.filter { $0.isSelected }.count == 1
    }
    
    var undealtCards: [Card] {
        cards.filter { !$0.isDealt && !$0.isDiscarded }
    }
    
    var discardedCards: [Card] {
        cards.filter { $0.isDiscarded }
    }
    
    private var cardCount : Int
    
    init() {
        dealtCards = [Card]()
        cards = [Card]()
        cardCount = 0
        let shapes = ["Diamond", "Squiggle", "Rectangle"]
        let counts = [1, 2, 3]
        let shading = [0.0, 0.5, 1.0]
        let colors = [Color.green, Color.red, Color.purple]
        var id = 1
        for shape in shapes {
            for count in counts {
                for shade in shading {
                    for color in colors {
                        cards.append(Card(id: id, color: color, number: count, shape: shape, shading: shade, isSelected: false, isMatched: false, isInUnmatchedSet: false, isDealt: false, isDiscarded: false))
                        id += 1
                    }
                }
            }
        }
        // cards.shuffle()
    }
    
    mutating func getCardsToDeal() -> [Card] {
        var cardsToDeal = [Card]()
        if cardCount < cards.count {
            for index in cardCount ... cardCount + 2 {
                cardsToDeal.append(cards[index])
            }
            cardCount += 3
        }
        
        return cardsToDeal
    }
    
    mutating func dealCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id} ) {
            cards[index].isDealt = true
            if let replacementIndex = dealtCards.firstIndex(where: { $0.isMatched }) {
                var cardToDiscard = dealtCards[replacementIndex]
                if let discardIndex = cards.firstIndex(where: { $0.id == cardToDiscard.id } ) {
                    cards[discardIndex].isDiscarded = true
                }
                dealtCards[replacementIndex] = cards[index]
            } else {
                dealtCards.append(cards[index])
            }
        }
    }
    
    mutating func deal() {

            if cardCount < cards.count {
                for index in cardCount ... cardCount + 2 {
                    cards[index].isDealt = true
                    dealtCards.append(cards[index])
                }
                cardCount += 3
            }
        
    }
    
    mutating func choose(_ card: Card) {
        
        if let chosenIndex = dealtCards.firstIndex(where: { $0.id == card.id }) {
            print("Chose card:\(dealtCards[chosenIndex])")
            if (dealtCards[chosenIndex].isMatched) {
                // Can't select a card that was already selected
                return
            }
            dealtCards[chosenIndex].isSelected.toggle()
            let sc = dealtCards.filter{ $0.isSelected == true}

            var madeASet = false
            if (sc.count == 3) {
                madeASet = isSet(sc)
                
                let index1 = dealtCards.firstIndex(of: sc[0])
                let index2 = dealtCards.firstIndex(of: sc[1])
                let index3 = dealtCards.firstIndex(of: sc[2])
                
                if (madeASet) {
                    dealtCards[index1!].isMatched = true
                    dealtCards[index2!].isMatched = true
                    dealtCards[index3!].isMatched = true
                    
                    // A set was made; deselect the set
                    for index in dealtCards.indices {
                        dealtCards[index].isSelected = false
                    }
                } else {
                    dealtCards[index1!].isInUnmatchedSet = true
                    dealtCards[index2!].isInUnmatchedSet = true
                    dealtCards[index3!].isInUnmatchedSet = true
                }
            } else {
                for index in dealtCards.indices {
                    dealtCards[index].isInUnmatchedSet = false
                }
            }
            
            if sc.count > 3 {

                for index in dealtCards.indices {
                    dealtCards[index].isSelected = false
                }
                
                dealtCards[chosenIndex].isSelected = true
            }
        }
    }
    
    mutating func shuffle() {
        dealtCards.shuffle()
    }
    
    // MARK: - private
    
    private mutating func replaceDeal() {
        for index in dealtCards.indices {
            if (dealtCards[index].isMatched) {
                if let card_index = cards.firstIndex(where: { $0.id == dealtCards[index].id }) {
                    cards[card_index].isDiscarded = true
                }
                
                cards[cardCount].isDealt = true
                dealtCards[index] = cards[cardCount]
                cardCount += 1
                
            }
        }
    }
    
    private func isSet(_ sc: [Card]) -> Bool {
        var madeASet = false
        // Check some game rules
        if (sc[0].color == sc[1].color ) && (sc[0].color == sc[2].color) {
            madeASet = true
        } else if (sc[0].number == sc[1].number ) && (sc[0].number == sc[2].number) {
            madeASet = true
        } else if (sc[0].shape == sc[1].shape ) && (sc[0].shape == sc[2].shape) {
            madeASet = true
        } else if (sc[0].shading == sc[1].shading ) && (sc[0].shading == sc[2].shading) {
            madeASet = true
        } else if (sc[0].color != sc[1].color ) && (sc[0].color != sc[2].color) && (sc[1].color != sc[2].color) &&
                    (sc[0].number != sc[1].number ) && (sc[0].number != sc[2].number) && (sc[1].number != sc[2].number) &&
                    (sc[0].shape != sc[1].shape ) && (sc[0].shape != sc[2].shape) && (sc[1].shape != sc[2].shape) &&
                    (sc[0].shading != sc[1].shading ) && (sc[0].shading != sc[2].shading) && (sc[1].shading != sc[2].shading) {
            madeASet = true
        }
        
        if ((sc[0].color == sc[1].color ) && (sc[1].color != sc[2].color)) ||
           ((sc[0].color == sc[2].color) && (sc[1].color != sc[2].color)) ||
           ((sc[1].color == sc[2].color) && (sc[0].color != sc[1].color)) ||
            ((sc[0].number == sc[1].number ) && (sc[1].number != sc[2].number)) ||
               ((sc[0].number == sc[2].number) && (sc[1].number != sc[2].number)) ||
               ((sc[1].number == sc[2].number) && (sc[0].number != sc[1].number)) ||
            ((sc[0].shape == sc[1].shape ) && (sc[1].shape != sc[2].shape)) ||
               ((sc[0].shape == sc[2].shape) && (sc[1].shape != sc[2].shape)) ||
               ((sc[1].shape == sc[2].shape) && (sc[0].shape != sc[1].shape)) ||
            ((sc[0].shading == sc[1].shading ) && (sc[1].shading != sc[2].shading)) ||
               ((sc[0].shading == sc[2].shading) && (sc[1].shading != sc[2].shading)) ||
               ((sc[1].shading == sc[2].shading) && (sc[0].shading != sc[1].shading)) {
            madeASet = false
        }
        
        return madeASet
    }
    
    // MARK: - Card
    
    struct Card: Hashable, Identifiable {
        var id: Int
        
        var color: Color
        var number: Int
        var shape: String
        var shading: Double
        var isSelected: Bool
        var isMatched: Bool
        var isInUnmatchedSet: Bool
        var isDealt: Bool
        var isDiscarded: Bool
    }
}

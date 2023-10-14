//
//  SwiftUIView.swift
//  SET
//
//  Created by Naomi Anderson on 10/14/23.
//

import SwiftUI

struct CardView: View {
    let card: SetCard.Card
    
    init(_ card: SetCard.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(card.isMatched ? .black : .white)
                .fill(card.isInUnmatchedSet ? .red : .white)
                .strokeBorder(card.isSelected ? .blue : .black, lineWidth: card.isSelected ? 4 : 2)
                .opacity(card.isMatched ? 0.25 : 1)
                .opacity(card.isInUnmatchedSet ? 0.5 : 1)
            VStack {
                if card.shape == "Diamond" {
                    ForEach(0 ..< card.number, id: \.self) {_ in
                        DiamondFillAndStroke(card)
                    }
                } else if card.shape == "Squiggle" {
                    ForEach(0 ..< card.number, id: \.self) {_ in
                        SquiggleFillAndStroke(card)
                    }
                } else {
                    ForEach(0 ..< card.number, id: \.self) {_ in
                        OvalFillAndStroke(card)
                    }
                }
            }
            .padding()
            
        }
    }
}

struct DiamondFillAndStroke: View {
    let card: SetCard.Card
    
    init(_ card: SetCard.Card) {
        self.card = card
    }
    
    var body: some View {
        if card.shading == 0 {
            Diamond()
                .stroke(card.color, lineWidth: 2)
        } else {
            Diamond()
                .stroke(card.color, lineWidth: 2)
                .fill(card.color)
                .opacity(card.shading)
        }
    }
}

struct SquiggleFillAndStroke: View {
    
    let card: SetCard.Card
    
    init(_ card: SetCard.Card) {
        self.card = card
    }
    
    var body: some View {
        if card.shading == 0 {
            Rectangle()
                .strokeBorder(card.color, lineWidth: 2)
        } else {
            Rectangle()
                .strokeBorder(card.color, lineWidth: 2)
                .fill(card.color)
                .opacity(card.shading)
        }
    }
}

struct OvalFillAndStroke: View {
    
    let card: SetCard.Card
    
    init(_ card: SetCard.Card) {
        self.card = card
    }
    
    var body: some View {
        if card.shading == 0 {
            RoundedRectangle(cornerRadius: 35)
                .strokeBorder(card.color, lineWidth: 2)
        } else {
            RoundedRectangle(cornerRadius: 35)
                .strokeBorder(card.color, lineWidth: 2)
                .fill(card.color)
                .opacity(card.shading)
        }
    }
}



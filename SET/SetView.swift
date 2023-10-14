//
//  ContentView.swift
//  SET
//
//  Created by Naomi Anderson on 10/4/23.
//

import SwiftUI

struct SetView: View {
    
    @ObservedObject var setGame: SetGame
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace
    
    private let aspectRatio: CGFloat = 2/3
    private let deckWidth: CGFloat = 50
    
    
    var body: some View {
        VStack {
            Button(action: {
                setGame.newGame()
            }, label: {
                Text("New Game")
            })
            cards
            HStack {
                deck
                Spacer()
                discardDeck
            }
            .padding()
            
        }
    }
    
    
    private var cards: some View {
        AspectVGrid(setGame.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .onTapGesture {
                    //setGame.replaceDeal()
                    setGame.choose(card)
                }
        }
        .padding()
    }
    
    private var deck: some View {
        ZStack {
            ForEach(setGame.undealtCards) { card in
                CardView(card)
                   // .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    //.transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio )
        .onTapGesture {
            setGame.deal()
        }
    }
    
    private var discardDeck: some View {
        ZStack {
            ForEach(setGame.discardedCards) { card in
                CardView(card)
                   // .matchedGeometryEffect(id: card.id, in: discardNamespace)
                   // .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio )
    }
    
}

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
                } else if card.shape == "Squiggle" {
                    ForEach(0 ..< card.number, id: \.self) {_ in
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
                } else {
                    ForEach(0 ..< card.number, id: \.self) {_ in
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
            }
            .padding()
            
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path() { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            p.closeSubpath()
        }
    }
}

#Preview {
    SetView(setGame: SetGame())
}

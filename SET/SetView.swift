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
    
    private let dealAnimation: Animation = .spring(response: 0.5, dampingFraction: 0.825)
    private let dealInterval: TimeInterval = 0.15
    
    private let aspectRatio: CGFloat = 2/3
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            Button(action: {
                setGame.newGame()
                deal()
            }, label: {
                Text("New Game")
            })
            cards
            HStack {
                deck
                Spacer()
                Button(action: {
                    withAnimation {
                        setGame.shuffle()
                    }
                }, label: {
                    Text("Shuffle")
                })
                Spacer()
                discardDeck
            }
            .padding()
            
        }
    }
    
    
    private var cards: some View {
        AspectVGrid(setGame.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
                .onTapGesture {
                    setGame.choose(card)

                    if setGame.matchedSetExists {
                        discardMatchedCards()
                    }
                }
        }
        .padding()
    }
    
    private var deck: some View {
        ZStack {
            ForEach(setGame.undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio )
        .onTapGesture {
            deal()
        }
    }
    
    private var discardDeck: some View {
        ZStack {
            ForEach(setGame.discardedCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio )
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        let cards = setGame.getCardsToDeal()
        for card in cards {
            withAnimation(dealAnimation.delay(delay)) {
                setGame.dealCard(card)
            }
            delay += dealInterval
        }
    }
    
    private func discardMatchedCards() {
        var delay: TimeInterval = 0
        let cards = setGame.getCardsToDiscard()
        for card in cards {
            withAnimation(dealAnimation.delay(delay)) {
                setGame.discardCard(card)
            }
            delay += dealInterval
        }
    }
    
    func getColorFromString(_ colorString: String) -> Color {
        switch colorString {
        case "purple":
            return Color.purple
        case "red":
            return Color.red
        case "green":
            return Color.green
        default:
            return Color.yellow
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

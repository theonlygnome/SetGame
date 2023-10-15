//
//  Cardify.swift
//  SET
//
//  Created by Naomi Anderson on 10/15/23.
//
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isDealt: Bool) {
        rotation = isDealt ? 0 : 180
    }
    
    var isDealt: Bool {
        rotation < 90
    }
    
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isDealt ? 1 : 0)
            base.fill()
                .opacity(isDealt ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
        
        
        
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
    
    
}

extension View {
    func cardify(isDealt: Bool) -> some View {
        modifier(Cardify(isDealt: isDealt))
    }
}

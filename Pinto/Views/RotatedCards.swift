//
//  RotatedCards.swift
//  Pinto
//
//  Created by Cesar on 15/11/21.
//

import SwiftUI

struct RotatedCards_Previews: PreviewProvider {
    static var previews: some View {
        RotatedCards(size: CGSize(width: 100, height: 100))
            .environmentObject(PintoGame<String>())
    }
}

struct RotatedCards: View {
    @EnvironmentObject var viewData: PintoGame<String>
    var size: CGSize
    
    var body: some View{
        LazyHGrid(rows: rows(size: size), spacing: size.width/CardConstants.spacingScale) {
            
            CardsOnTable(mPlayer: .p3, size: size).rotationEffect(Angle(degrees: 90)).padding(.leading)
            
            HStack{
                //For all available Cards
                //If there is none then load the placeholder
                
                if(!viewData.initialDeck.isEmpty) {
                    CardView(card: Card(id: 100, content: "facedown", value: 0), size: size, includeShadow: false)
                        .padding(.trailing)
                } else {
                    CardView(card: Card.default, size: size, includeShadow: false)
                        .padding(.trailing)
                }
                
                
                //For discarted cards do not show all of them just the last one
                CardView(card: viewData.cardToBeat, size: size, includeShadow: false)
            }
            
            
            CardsOnTable(mPlayer: .p4, size: size).rotationEffect(Angle(degrees: 90)).padding(.leading)
        }.frame(width: size.width)
    }
}

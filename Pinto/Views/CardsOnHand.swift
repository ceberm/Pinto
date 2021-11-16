//
//  CardsOnHand.swift
//  Pinto
//
//  Created by Cesar on 15/11/21.
//

import SwiftUI


struct CardsOnHand: View {
    
    @EnvironmentObject var viewData: PintoGame<String>
    var mPlayer: Players
    var size: CGSize
    
    var body: some View {
        // Para las cartas que se comen del pozo y las cartas en mano
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns(size: size), spacing: CardConstants.defaultSpacing/CardConstants.spacingScale){
                ForEach(viewData.getCardsOnHand(mPlayer)) { card in
                    CardView(card: card, size: size, includeShadow: false).onTapGesture {
                        viewData.pick(card: card, player: mPlayer)
                    }
                }
            }
        }
        .padding()
    }
}

struct CardsOnHand_Previews: PreviewProvider {
    static var previews: some View {
        CardsOnHand(mPlayer: .p1, size: CGSize(width: 100, height: 100))
            .environmentObject(PintoGame<String>())
    }
}

//
//  CardsOnTable.swift
//  Pinto
//
//  Created by Cesar on 15/11/21.
//

import SwiftUI

struct CardsOnTable: View {
    @EnvironmentObject var viewData: PintoGame<String>
    var mPlayer: Players
    var size: CGSize
    
    var body: some View{
        LazyHGrid(rows: rows(size: size), spacing: CardConstants.defaultSpacing) {
            ForEach(viewData.getFaceUpCards(mPlayer)){ card in
                CardView(card: card, size: size).onTapGesture {
                    viewData.pickTableCard(card: card, player: mPlayer)
                    
                }
            }
        }
    }
}

struct CardsOnTable_Previews: PreviewProvider {
    static var previews: some View {
        CardsOnTable(mPlayer: .p2, size: CGSize(width: 100, height: 100))
            .environmentObject(PintoGame<String>())
    }
}

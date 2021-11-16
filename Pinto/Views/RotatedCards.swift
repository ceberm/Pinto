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
            
//            HStack{ //For Player 3
//                ForEach(viewModel.getFaceUpCards(Players.p3)){ card in
//                    CardView(card: card, size: proxy.size)
//                }
//            }.rotationEffect(Angle(degrees: 90)).padding(.leading)
            
            HStack{
                //For all available Cards
                CardView(card: Card(id: 100, content: String.init(), value: 0), size: size, includeShadow: false)
                    .padding(.trailing)
                
                //For discarted cards do not show all of them just the last one
                CardView(card: viewData.cardToBeat, size: size, includeShadow: false)
            }
            
            
//            HStack{ //For Player 4
//                ForEach(viewModel.getFaceUpCards(Players.p4)){ card in
//                    CardView(card: card, size: proxy.size)
//                }
//            }.rotationEffect(Angle(degrees: 90)).padding(.trailing)
        }.frame(width: size.width)
    }
}

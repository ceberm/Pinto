//
//  ContentView.swift
//  TopinApp
//
//  Created by Cesar on 13/6/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PintoCardGame
    
    var body: some View {
        VStack{
            HStack{ //For Player 1
                ForEach(viewModel.getFaceUpCards(Players.p1)){ card in
                    ZStack{
                        //CardView(contentImage: "facedown")
                        CardView(contentImage: card.content).onTapGesture {
                            viewModel.chooseCard(card: card)
                        }
                        //.rotationEffect(Angle(degrees: 90))
                        //.animation(.ripple(index: card.id))
                    }
                }.padding(5)
            }.padding(.vertical)
            
           /* HStack{ // For current Game
                ForEach(viewModel.faceDownCards){ card in
                    ZStack{
                        if(card.isFaceUp){
                            CardView(contentImage: card.content)
                        }
                        else {
                            CardView(contentImage: "facedown")
                        }
                    }
                }
            }.padding(.vertical)
            
            HStack{ // For Player 2
                ForEach(viewModel.faceDownCards){ card in
                    ZStack{
                        if(card.isFaceUp){
                            CardView(contentImage: card.content)
                        }
                        else {
                            CardView(contentImage: "facedown")
                        }
                    }
                }.padding(5)
            }.padding(.vertical)*/
        }
    }
}

struct CardView: View {
    var contentImage: String
    var body: some View {
        Image(contentImage)
            .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
            .shadow(radius: 8)
    }
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let borderWidth: CGFloat = 0.55
    static let undealtHeight: CGFloat = 101 // divide by number of players
    static let undealtWidth = undealtHeight * aspectRatio
}

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}





































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.light)
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.dark)
        
    }
}

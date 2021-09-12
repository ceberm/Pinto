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
            ScrollView{ //For Player 1
                ForEach(viewModel.faceUpCards){ card in
                    ZStack{
                        if(card.isFaceUp){
                            CardView(contentImage: card.content).onTapGesture {
                                viewModel.chooseCard(card: card)
                            }
                        }
                        else {
                            CardView(contentImage: "facedown")
                        }
                    }
                }.padding(5)
            }.padding(.vertical)
            
            /*HStack{ // For current Game
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
            .border(Color.black, width: CardConstants.borderWidth)
    }
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let borderWidth: CGFloat = 0.55
    static let undealtHeight: CGFloat = 101 // divide by number of players
    static let undealtWidth = undealtHeight * aspectRatio
}









































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.light)
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.dark)
        
    }
}

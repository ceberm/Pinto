//
//  ContentView.swift
//  TopinApp
//
//  Created by Cesar on 13/6/21.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: PintoCardGame
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                ScrollView(showsIndicators: false) {
                    
                    LazyHGrid(rows: rows(size: proxy.size), spacing: CardConstants.defaultSpacing) { // View For Player 3
                        ForEach(viewModel.getFaceUpCards(Players.p3)){ card in
                            CardView(card: card, size: proxy.size)
                        }
                    }.frame(width: proxy.size.width)
                    
                    
                    LazyHGrid(rows: rows(size: proxy.size), spacing: proxy.size.width/CardConstants.spacingScale) { //For Player 2
                        
                        HStack{
                            ForEach(viewModel.getFaceUpCards(Players.p2)){ card in
                                CardView(card: card, size: proxy.size)
                            }
                        }.rotationEffect(Angle(degrees: 90)).padding(.leading)
                        
                        ZStack{ //For Cards on the deck and the discarted ones
                            ForEach(viewModel.getInitialCards()){ card in
                                CardView(card: card, size: proxy.size, includeShadow: false)
                            }
                        }.padding(.trailing)
                        
                        ZStack{
                            ForEach(viewModel.getDiscartedCards()){ card in
                                CardView(card: card, size: proxy.size, includeShadow: false)
                            }
                        }
                        
                        
                        HStack{
                            ForEach(viewModel.getFaceUpCards(Players.p4)){ card in
                                CardView(card: card, size: proxy.size)
                            }
                        }.rotationEffect(Angle(degrees: 90)).padding(.trailing)
                    }.frame(width: proxy.size.width).padding(.top)
                    
                    LazyHGrid(rows: rows(size: proxy.size), spacing: CardConstants.defaultSpacing) { //For Player 1
                        ForEach(viewModel.getFaceUpCards(Players.p1)){ card in
                            CardView(card: card, size: proxy.size).onTapGesture {
                                viewModel.chooseCard(card: card)
                            }
                            
                        }
                    }.frame(width: proxy.size.width)
                    .padding(.top, max(proxy.size.height,proxy.size.width) - max(proxy.size.height,proxy.size.width) * 0.95 )
                }
                
                
                // Para las cartas que se comen del pozo y las cartas en mano
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns(size: proxy.size), spacing: 5.0) {
                        ForEach(viewModel.getFaceDownCards(Players.p1)){ card in
                            CardView(card: card, size: proxy.size).onTapGesture {
                                viewModel.chooseCard(card: card)
                            }
                        }
                        
                    }
                }.padding()
            }
        }
    }
}

struct CardView: View {
    var card: Card
    var size: CGSize
    var includeShadow: Bool = true
    var body: some View {
        
        if(card.isFaceUp){
            if(includeShadow){
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                    .shadow(radius: 8)
            }else {
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.3))
            }
        }else {
            Image("facedown")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
        }
        
    }
}

func columns(size: CGSize) -> [GridItem] {
    [
        GridItem(.adaptive(
                    minimum: thumbnailSize(size: size).width))
    ]
}

func rows(size: CGSize) -> [GridItem] {
    [
        GridItem(.adaptive(
                    minimum: thumbnailSize(size: size).height))
    ]
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let borderWidth: CGFloat = 0.55
    static let undealtHeight: CGFloat = 99
    static let undealtWidth = undealtHeight * aspectRatio
    static let scale: CGFloat = 0.7
    static let spacingScale: CGFloat = 512
    static let defaultSpacing: CGFloat = 5.0
}

func thumbnailSize(size: CGSize) -> CGSize {
    return CGSize(width: CardConstants.undealtWidth * CardConstants.scale, height: CardConstants.undealtHeight * CardConstants.scale)
}






































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: PintoCardGame()).preferredColorScheme(.light).previewLayout(.fixed(width: 812, height: 375))
        GameView(viewModel: PintoCardGame()).preferredColorScheme(.light)
        //.previewLayout(.fixed(width: 812, height: 375))
        
    }
}

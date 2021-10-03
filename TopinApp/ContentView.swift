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
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                
            LazyHGrid(rows: rows(size: proxy.size), spacing: 10.0) { //For Player 1
                ForEach(viewModel.getFaceUpCards(Players.p1)){ card in
                    
                        //CardView(card: card, size: proxy.size).hidden()
                        CardView(card: card, size: proxy.size).onTapGesture {
                            viewModel.chooseCard(card: card)
                        }
                    
                }
            }.frame(width: proxy.size.width)
                
            
            LazyHGrid(rows: rows(size: proxy.size), spacing: proxy.size.width/3) { //For Player 2
                
                    HStack{
                    ForEach(viewModel.getFaceUpCards(Players.p2)){ card in
                            //CardView(contentImage: "facedown").hidden()
                        CardView(card: card, size: proxy.size)
                        
                        
                            //.animation(.ripple(index: card.id))
                    }
                    }
                    .rotationEffect(Angle(degrees: 90))
                
            
                    HStack{
                    ForEach(viewModel.getFaceUpCards(Players.p4)){ card in
                        
                            //CardView(contentImage: "facedown")
                        CardView(card: card, size: proxy.size)
                            
                            //.animation(.ripple(index: card.id))
                        
                        
                    }
                    }
                    .rotationEffect(Angle(degrees: 90))
            }
            .frame(width: proxy.size.width)
            
                
                
               /* LazyHGrid(rows: columns(size: proxy.size), spacing: 5.0) { //For Player 1
                    ForEach(viewModel.getFaceUpCards(Players.p1)){ card in
                        ZStack{
                            //CardView(contentImage: "facedown")
                            CardView(card: card, size: proxy.size).onTapGesture {
                                viewModel.chooseCard(card: card)
                            }
                            //.rotationEffect(Angle(degrees: 90))
                            //.animation(.ripple(index: card.id))
                        }
                    }
                }.frame(width: proxy.size.width * 0.8)
                    .background(Color.gray)
                    .padding(.leading, (proxy.size.width - proxy.size.width * 0.8) / 2)*/
            }
        }
    }
}

struct CardView: View {
    var card: Card
    var size: CGSize
    var body: some View {
        if(card.isFaceUp){
            //Text(card.content).font(.custom("custom1", fixedSize: min(size.width, size.height) / 4))
            Image(card.content)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                .shadow(radius: 8)
        }else {
            /*Image("facedown")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                .shadow(radius: 8)*/
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
    static let undealtHeight: CGFloat = 101 // divide by number of players
    static let undealtWidth = undealtHeight * aspectRatio
}

func thumbnailSize(size: CGSize) -> CGSize {
  let threshold: CGFloat = 500
  var scale: CGFloat = 0.75
  if size.width > threshold && size.height > threshold {
scale = 0.2 }
  return CGSize(
    width: CardConstants.undealtWidth * scale,
    height: CardConstants.undealtHeight * scale)
}


extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}





































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.light)
            //.previewLayout(.fixed(width: 812, height: 375))
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.light)
            .previewLayout(.fixed(width: 812, height: 375))
        
    }
}

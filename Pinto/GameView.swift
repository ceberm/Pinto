//
//  ContentView.swift
//  TopinApp
//
//  Created by Cesar on 13/6/21.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewData: PintoGame<String>
    @State private var showingCardPicker = false
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
            
                Player2Cards(proxy: proxy)
                    
                RotatedCards(proxy: proxy)
                
                Player1Cards(proxy: proxy)
                
                CardsOnHand(proxy: proxy)
                   
//                Button(action: { showingCardPicker.toggle() }) {
//                    Image(systemName: "square.stack.3d.forward.dottedline.fill")
//                        .accessibilityLabel("User Profile")
//                }
//
//                    .sheet(isPresented: $showingCardPicker) {
//
//                        Image(systemName: "gobackward")
//                            .accessibilityLabel("User Profile")
//                            .onTapGesture {
//                                showingCardPicker.toggle()
//                            }
//                    }.animation(.easeInOut)
            }
        }
        .background(LinearGradient(colors: [Color(hue: 0.272, saturation: 0.665, brightness: 0.192), Color(hue: 0.20, saturation: 0.62, brightness: 0.250)], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))).edgesIgnoringSafeArea(.all)
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
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
            }else {
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.3))
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
            }
        }else {
            Image("facedown")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                .clipped(antialiased: true)
                .contentShape(Rectangle())
            
        }
        
    }
}

struct Player1Cards: View {
    @EnvironmentObject var viewData: PintoGame<String>
    var proxy: GeometryProxy
    
    var body: some View{
        LazyHGrid(rows: rows(size: proxy.size), spacing: CardConstants.defaultSpacing) { //For Player 1
            ForEach(viewData.getFaceUpCards(.p1)){ card in
                CardView(card: card, size: proxy.size)
            }
        }.frame(width: proxy.size.width)
        .padding(.top, max(proxy.size.height,proxy.size.width) - max(proxy.size.height,proxy.size.width) * 0.99 )
    }
}

struct RotatedCards: View {
    @EnvironmentObject var viewData: PintoGame<String>
    var proxy: GeometryProxy
    
    var body: some View{
        LazyHGrid(rows: rows(size: proxy.size), spacing: proxy.size.width/CardConstants.spacingScale) {
            
//            HStack{ //For Player 3
//                ForEach(viewModel.getFaceUpCards(Players.p3)){ card in
//                    CardView(card: card, size: proxy.size)
//                }
//            }.rotationEffect(Angle(degrees: 90)).padding(.leading)
            
            HStack{
                //For all available Cards
                CardView(card: Card(id: 100, content: String.init(), value: 0), size: proxy.size, includeShadow: false)
                    .padding(.trailing)
                
                //For discarted cards do not show all of them just the last one
                CardView(card: viewData.cardToBeat, size: proxy.size, includeShadow: false)
            }
            
            
//            HStack{ //For Player 4
//                ForEach(viewModel.getFaceUpCards(Players.p4)){ card in
//                    CardView(card: card, size: proxy.size)
//                }
//            }.rotationEffect(Angle(degrees: 90)).padding(.trailing)
        }.frame(width: proxy.size.width)
    }
}

struct Player2Cards: View {
    @EnvironmentObject var viewData: PintoGame<String>
    var proxy: GeometryProxy
    
    var body: some View{
        LazyHGrid(rows: rows(size: proxy.size), spacing: CardConstants.defaultSpacing) { // View For Player 3
            ForEach(viewData.getCardsOnHand(.p2)){ card in
                CardView(card: card, size: proxy.size)
            }
        }
    }
}

struct CardsOnHand: View {
    
    @EnvironmentObject var viewData: PintoGame<String>
    
    var proxy: GeometryProxy
    
    var body: some View {
        // Para las cartas que se comen del pozo y las cartas en mano
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns(size: proxy.size), spacing: CardConstants.defaultSpacing/CardConstants.spacingScale) {
                ForEach(viewData.getCardsOnHand(.p1)) { card in
                    CardView(card: card, size: proxy.size, includeShadow: false).onTapGesture {
                                    viewData.pick(card: card, player: Players.p1)
                                }
                    
                }
            }
        }
        .padding()
        //.frame(width: proxy.size.width, height: proxy.size.height/5, alignment: .leading)
    }
}


func columns(size: CGSize) -> [GridItem] {
    [
        GridItem(.adaptive(minimum: 54))
    ]
}

func rows(size: CGSize) -> [GridItem] {
    [
        GridItem(.flexible(
                    minimum: thumbnailSize(size: size).height))
    ]
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let borderWidth: CGFloat = 0.55
    static let undealtHeight: CGFloat = 99
    static let undealtWidth = undealtHeight * aspectRatio
    static let scale: CGFloat = 0.8
    static let spacingScale: CGFloat = 500
    static let defaultSpacing: CGFloat = 5.0
}

func thumbnailSize(size: CGSize) -> CGSize {
    return CGSize(width: CardConstants.undealtWidth * CardConstants.scale, height: CardConstants.undealtHeight * CardConstants.scale)
}






































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            GameView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
                .environmentObject(PintoGame<String>())
        } else {
            GameView().preferredColorScheme(.light)
                .environmentObject(PintoGame<String>())
        }
        //.previewLayout(.fixed(width: 812, height: 375))
        
    }
}

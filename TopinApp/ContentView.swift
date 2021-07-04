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
            HStack{
                ForEach(viewModel.faceDownCards){ card in
                    ZStack{
                        CardViewFaceDown()
                        CardView()
                    }
                }.padding(.top, 21)
            }.padding(.vertical)
            
            HStack{
                ForEach(viewModel.faceDownCards){ card in
                    ZStack{
                        CardViewFaceDown().onTapGesture {
                            viewModel.chooseCard(card: card)
                        }
                    }
                }
            }.padding(.vertical)
            
            HStack{
                ForEach(viewModel.faceDownCards){ card in
                    ZStack{
                        CardView()
                    }
                }
            }.padding(.vertical)
        }
    }
}

struct CardViewFaceDown: View {
    private func body(for size: CGSize) -> some View {
        Image("facedown")
            .resizable()
            .interpolation(.medium)
            .scaledToFill()
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
            .border(Color.black, width: 1)
            .clipped()
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
                .position(x: geometry.size.width/2, y: geometry.size.height/3)
        }
    }
}

struct CardView: View {
    private func body(for size: CGSize) -> some View {
        Image("2")
            .resizable()
            .interpolation(.medium)
            .scaledToFill()
            .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
            .border(Color.black, width: 1)
            .clipped()
    }
    
    var body: some View {
        GeometryReader { geometry in
           body(for: geometry.size)
            .position(x: geometry.size.width/2, y: geometry.size.height/3)
        }
    }
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
    static let undealtHeight: CGFloat = 101
    static let undealtWidth = undealtHeight * aspectRatio
    static let gradientStart = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}









































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.light)
        ContentView(viewModel: PintoCardGame()).preferredColorScheme(.dark)
        
    }
}

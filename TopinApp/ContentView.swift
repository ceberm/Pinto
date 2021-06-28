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
                ForEach(viewModel.p2Cards){ card in
                    CardView(card: card)
                }
            }.padding(.horizontal)
            HStack{
                ForEach(viewModel.p1Cards){ card in
                    CardView(card: card)
                }
            }.padding(.horizontal)
            HStack{
                ForEach(viewModel.p1Cards){ card in
                    CardView(card: card)
                }
            }.padding(.horizontal)
        }
    }
}

struct CardView: View {
    var items: [GridItem] = Array(repeating: .init(.fixed(120)), count: 1)
    var card: PintoGame<String>.Card
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
            Text(card.content)
                .font(Font.system(size: fontSize(for: size)))
    }
    
    var body: some View {
        GeometryReader { geometry in
           body(for: geometry.size)
            .position(.init(x: geometry.size.width/2, y: geometry.size.height/2))
        }
    }
    
    //MARK: -Drawing Constants
    private let fontScaleFactor: CGFloat = 0.5
    
    private func fontSize(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * fontScaleFactor
    }
}

private struct CardConstants {
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
    static let undealtHeight: CGFloat = 99
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

//
//  ContentView.swift
//  TopinApp
//
//  Created by Cesar on 13/6/21.
//

import SwiftUI

struct ContentView: View {
    
    let cards = ["🂢", "🂣", "🂤"]
    var emojiCount = 3
    
    var body: some View {
        HStack{
            ForEach(cards[0..<emojiCount], id: \.self) {
                card in
                CardView(content: card).aspectRatio(5/7, contentMode: .fit)
            }
        }
    }
}


struct CardView: View {
    
    static let gradientStart = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    @State var isFaceUp = false
    var content: String
    
    var myCustomCardView: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 21.0)
            if isFaceUp {
                shape.fill().foregroundColor(.clear)
                Text(content)
                    .font(.system(size: 144).weight(.ultraLight))
                    .frame(width: 99.0, height: 147)
                    
            }else{
                shape.fill(LinearGradient(
                    gradient: Gradient(colors: [Self.gradientStart, Self.gradientEnd]), startPoint: UnitPoint(x: 0.2, y: 0.1), endPoint: UnitPoint(x: 0.5, y: 23)
                )).aspectRatio(0.77, contentMode: .fit)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    
    var body: some View {
        myCustomCardView
    }
}









































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}

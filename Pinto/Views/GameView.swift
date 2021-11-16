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
            
                CardsOnTable(mPlayer: .p2, size: proxy.size)
                    
                RotatedCards(size: proxy.size)
                
                CardsOnTable(mPlayer: .p1, size: proxy.size)
                
                CardsOnHand(mPlayer: .p1, size: proxy.size)
                   
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

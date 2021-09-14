//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import SwiftUI

///View Model
class PintoCardGame: ObservableObject {
    @Published private var model: PintoGame<String> = createPintoGame()
    
    private static func createPintoGame() -> PintoGame<String>{
        return PintoGame<String>()
    }
    
    //MARK: - Access to the Model
    
    var player1Cards: Array<PintoGame<String>.Card>{
        model.player1.playerCards
    }
    
    var player2Cards: Array<PintoGame<String>.Card>{
        model.player2.playerCards
    }
    
    //MARK: - Inten(s)
    
    func chooseCard(card: PintoGame<String>.Card){
        model.pick(card: card)
    }
    
    func getFaceDownCards(_ player: Players) -> Array<PintoGame<String>.Card> {
        return model.getFaceDownCards(player)
    }
    
    func getFaceUpCards(_ player: Players) -> Array<PintoGame<String>.Card> {
        return model.getFaceUpCards(player)
    }
}

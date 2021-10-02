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
    
    var player1Cards: Array<Card>{
        model.players[0].playerCards
    }
    
    var player2Cards: Array<Card>{
        model.players[1].playerCards
    }
    
    //MARK: - Intent(s)
    
    func chooseCard(card: Card){
        model.pick(card: card)
    }
    
    func getFaceDownCards(_ player: Players) -> Array<Card> {
        return model.getFaceDownCards(player)
    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        return model.getFaceUpCards(player)
    }
}

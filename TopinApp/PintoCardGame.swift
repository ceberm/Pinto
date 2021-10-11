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
    
    //MARK: Playabilty
    static func startGame() {
        
        var initialCard = selectMinimalCard()
        
    }
    
    func resetPintoGame(){
        model = PintoCardGame.createPintoGame()
    }
    
    func createTurns() {
        #warning ("Create Turns")
    }
    
    static func selectMinimalCard() -> Card {
        #warning ("Select minimal card to begin with")
    }
    
    func drawCard() {
        #warning ("draw card to the on hand cards")
    }
    
    func moveToDiscarted() {
        #warning ("Make pick a card move to discarted")
        #warning ("Make the discarted be bigger than the current discarted")
    }
    
    //MARK: - Access to the Model
    
    func getFaceDownCards(_ player: Players) -> Array<Card> {
        return model.getFaceDownCards(player)
    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        return model.getFaceUpCards(player)
    }
    
    func getCardsOnHand(_ player: Players) -> Array<Card> {
        return model.getCardsOnHand(player)
    }
    
    func getInitialCards() -> Array<Card> {
        return model.initialDeck
    }
    
    func getDiscartedCards() -> Array<Card> {
        return model.discartedCards
    }
    
    //MARK: - Intent(s)
    
    func chooseCard(card: Card){
        model.pick(card: card)
    }
    
    
}

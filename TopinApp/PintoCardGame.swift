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
    
    init(){
        startGame()
    }
    
    //MARK: Playabilty
    func startGame() {
        let initialCard = selectMinimalCard()
        moveToDiscarted(card: initialCard)
    }
    
    func resetPintoGame(){
        model = PintoCardGame.createPintoGame()
    }
    
    func createTurns() {
        #warning ("Create Turns")
    }
    
    /**
     This method is to select the initial card and make the respective user draw one card from the available cards
     */
    func selectMinimalCard() -> Card {
        let arr = model.getCardsOnHand(Players.p1) + model.getCardsOnHand(Players.p2) +  model.getCardsOnHand(Players.p3) +  model.getCardsOnHand(Players.p4)
        
        return arr.min { card1, card2 in
            card1.value < card2.value
        }!
        
    }
    
    func drawCard() {
        #warning ("draw card to the on hand cards")
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
    
    func getLastDiscarted() -> Card {
        let last = model.discartedCards.last
        return last!
    }
    
    func moveToDiscarted(card: Card) {
        model.discartedCards.append(card)
    }
    
    //MARK: - Intent(s)
    
    func chooseCard(card: Card){
        model.pick(card: card)
        moveToDiscarted(card: card)
    }
    
    
}

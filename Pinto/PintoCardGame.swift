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
        model.moveToDiscarted(card: initialCard)
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
        
        model.getCardsOnHand(Players.p1)[0] as Card
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
        model.getLastDiscarted()
    }
    
    //MARK: - Intent(s)
    
    func chooseCard(card: Card, player: Players){
        model.pick(card: card, player: player)
    }
    
    
}

extension Card {
    static func >=(lhs: Card, rhs: Card) -> Bool {
        lhs.value >= rhs.value
    }
}

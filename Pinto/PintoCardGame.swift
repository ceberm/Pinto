//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import SwiftUI

///View Model
class PintoCardGame: ObservableObject {
    @ObservedObject private var modelData: PintoGame<String> = PintoGame<String>()
    
    private func createPintoGame() -> PintoGame<String>{
        return PintoGame<String>()
    }
    
    init() {
        startGame()
    }
    
    //MARK: Playabilty
    func startGame() {
        do {
            try modelData.loadPlayers(2)
        } catch PintoModelError.deckIsEmpty {
            print("Error loading model, deck of cards is empty")
        } catch PintoModelError.invalidNumberOfPlayers {
            print("The number of players selected is invalid")
        } catch {
            print("Unexpected error: \(error).")
        }
        modelData.selectMinimalCard()
    }
    
    func resetPintoGame(){
        modelData = createPintoGame()
    }
    
    func createTurns() {
        
        #warning ("Crear Turnos")
        
    }
    
    
    //MARK: - Access to the Model
    
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        return modelData.getFaceUpCards(player)
    }
    
    func getCardsOnHand(_ player: Players) -> Array<Card> {
        return modelData.getCardsOnHand(player)
    }
    
    func getInitialCards() -> Array<Card> {
        return modelData.initialDeck
    }
    
    func getDiscartedCards() -> Array<Card> {
        return modelData.discartedCards
    }
    
    func getLastDiscarted() -> Card {
        modelData.cardToBeat
    }
    
    //MARK: - Intent(s)
    
    func chooseCard(card: Card, player: Players){
//        let lastCart = modelData.cardToBeat
//        if(card >= lastCart || card.hasCleanEffect || card.hasReverseEffect){
//            modelData.pick(card: card, player: player)
//        }
        modelData.pick(card: card, player: player)
    }
    
    
}

extension Card {
    static func >=(lhs: Card, rhs: Card) -> Bool {
        lhs.value >= rhs.value
    }
}

//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation
import SwiftUI

final class PintoGame<CardContent>: ObservableObject where CardContent: Equatable {
    
    //MARK: Init
    init() {
        startGame()
    }
    
    /// Cards Values in ASCII, every cards here are referenced on Assets folder
    private var default_cards:[String] = [
        "U+1F0A1", "U+1F0A2", "U+1F0A3", "U+1F0A4", "U+1F0A5", "U+1F0A6", "U+1F0A7", "U+1F0A8", "U+1F0A9", "U+1F0AA", "U+1F0AB","U+1F0AD", "U+1F0AE",
        "U+1F0B1", "U+1F0B2", "U+1F0B3", "U+1F0B4", "U+1F0B5", "U+1F0B6", "U+1F0B7", "U+1F0B8", "U+1F0B9", "U+1F0BA", "U+1F0BB", "U+1F0BD", "U+1F0BE",
        "U+1F0C1", "U+1F0C2", "U+1F0C3", "U+1F0C4", "U+1F0C5", "U+1F0C6", "U+1F0C7", "U+1F0C8", "U+1F0C9", "U+1F0CA", "U+1F0CB", "U+1F0CD", "U+1F0CE",
        "U+1F0D1", "U+1F0D2", "U+1F0D3", "U+1F0D4", "U+1F0D5", "U+1F0D6", "U+1F0D7", "U+1F0D8", "U+1F0D9", "U+1F0DA", "U+1F0DB", "U+1F0DD", "U+1F0DE"
    ]
    
    private(set) var initialDeck = Array<Card>()
    var discartedCards = Array<Card>()
    @Published private(set) var p1: Player?
    @Published private(set) var p2: Player?
    @Published private(set) var p3: Player?
    @Published private(set) var p4: Player?
    private var numberOfPlayers = 2
    var playerTurn = 1
    var movedThisTurn = false
    var usedComodin = false
    var goingBackwards = false
    var cardToBeat: Card = Card.default {
        willSet {
            objectWillChange.send()
        }
    }
    
    //MARK: Initialization Methods
    func startGame() {
        do {
            shuffleCards()
            try loadPlayers(2)
        } catch PintoModelError.deckIsEmpty {
            print("Error loading model, deck of cards is empty")
        } catch PintoModelError.invalidNumberOfPlayers {
            print("The number of players selected is invalid")
        } catch {
            print("Unexpected error: \(error).")
        }
        selectMinimalCard()
    }
    
    /// Creates Card Objects and assign them a value
    func shuffleCards(){
        for cardIndex in 0..<default_cards.count {
            let ascciValue = default_cards[cardIndex]
            let someCharacter: Character = ascciValue.last!
            switch someCharacter {
                case "1":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, value: 14))
                case "2":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, hasReverseEffect: true, value: 2))
//                case "7":
//                    initialDeck.append(Card(id: cardIndex, content: ascciValue, hasOnlySmallsEffect: true, value: 7))
//                case "8":
//                    initialDeck.append(Card(id: cardIndex, content: ascciValue, hasOnlyGreatersEffect: true, value: 8))
                case "A":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, hasCleanEffect: true, value: 10))
                case "B":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, value: 11))
                case "D":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, value: 12))
                case "E":
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, value: 13))
                default:
                    initialDeck.append(Card(id: cardIndex, content: ascciValue, value: Int(someCharacter.wholeNumberValue!)))
                    
            }
            
        }
        initialDeck.shuffle()
    }
    
    /**
     Select the initial card and make the respective user draw one card from the available cards
        In other words plays the first turn automatically
     **/
    func selectMinimalCard() {
        let min = getSetOfCards()
        
        cardToBeat = min.min(by: { c1, c2 in c2.value > c1.value })!
        cardToBeat.isFaceUp = true
        
        if((p1?.onHandCards.contains(cardToBeat)) == true) {
            moveToDiscarted(card: cardToBeat, player: &p1!)
            playerTurn = 1
        }
        if((p2?.onHandCards.contains(cardToBeat)) == true) {
            moveToDiscarted(card: cardToBeat, player: &p2!)
            playerTurn = 2
        }
        if((p3?.onHandCards.contains(cardToBeat)) == true) {
            moveToDiscarted(card: cardToBeat, player: &p3!)
            playerTurn = 3
        }
        if((p4?.onHandCards.contains(cardToBeat)) == true) {
            moveToDiscarted(card: cardToBeat, player: &p4!)
            playerTurn = 4
        }
        startTurn()
    }
    
    /// Gets all the cards on hand and mixes to find the minium
    private func getSetOfCards() -> Array<Card> {
        var result = [Card]()
        
        result.append(contentsOf: (p1?.onHandCards.filter { card in
            !card.hasCleanEffect && !card.hasReverseEffect
        })!)
        result.append(contentsOf: (p2?.onHandCards.filter { card in
            !card.hasCleanEffect && !card.hasReverseEffect
        })!)
        result.append(contentsOf: (p3?.onHandCards.filter { card in
            !card.hasCleanEffect && !card.hasReverseEffect
        }) ?? [Card]())
        result.append(contentsOf: (p4?.onHandCards.filter { card in
            !card.hasCleanEffect && !card.hasReverseEffect
        }) ?? [Card]())
        
        return result
    }
    
    func loadPlayers(_ numberOfPlayers: Int) throws {
        if(numberOfPlayers >= 2){
            for num in 1...numberOfPlayers {
                let player = try createPlayerWithCards(num)
                switch num {
                case 1:
                    p1 = player
                case 2:
                    p2 = player
                case 3:
                    p3 = player
                case 4:
                    p4 = player
                default:
                    throw PintoModelError.invalidNumberOfPlayers
                }
            }
        } else {
            throw PintoModelError.invalidNumberOfPlayers
        }
    }
    
    //MARK: Playability Methods
    
    func startTurn() {
        usedComodin = false
        movedThisTurn = false
        if (!goingBackwards) {
            if (playerTurn == numberOfPlayers) {
                playerTurn = 1
            } else { playerTurn = playerTurn + 1 }
        }
        else {
            if (playerTurn - 1  > 0){
                playerTurn = playerTurn - 1
            } else { playerTurn = numberOfPlayers } //if (playerTurn <= 0)
        }
        
    }
    
    func pick(card: Card, player: Players){
        if(card >= cardToBeat || card.hasCleanEffect || card.hasReverseEffect){
            switch player {
                case .p1:
                    moveToDiscarted(card: card, player: &p1!)
                case .p2:
                    moveToDiscarted(card: card, player: &p2!)
                case .p3:
                    moveToDiscarted(card: card, player: &p3!)
                case .p4:
                    moveToDiscarted(card: card, player: &p4!)
            }
        }
    
        if card.hasCleanEffect {
            discartedCards.removeAll()
            cardToBeat = Card.default
        }else { // If used a 2
            if(usedComodin){
                goingBackwards = card.hasReverseEffect
            }
        }
        
        print("goingBackwards \(goingBackwards)")
        print("playerTurn \(playerTurn)")
        startTurn()
        
    }
    
    /// A player has discarted a card we must therefore draw a new card and ends the current turn
    func moveToDiscarted(card: Card, player: inout Player) {
        discartedCards.append(card)
        cardToBeat = card
        usedComodin = card.hasCleanEffect || card.hasReverseEffect
        movedThisTurn = true
        guard let index = player.onHandCards.firstIndex(of: card) else { return }
        var newCard: Card? = initialDeck.remove(at: 0)
        if (newCard != nil) {
            newCard!.isFaceUp = true
            newCard!.isOnHand = true
            player.onHandCards[index] = newCard!
        }
    }
    
    func pickTableCard(card: Card, player: Players){
        if(card >= cardToBeat || card.hasCleanEffect || card.hasReverseEffect){
            switch player {
                case .p1:
                    discardTableCard(card: card, player: &p1!)
                case .p2:
                    discardTableCard(card: card, player: &p2!)
                case .p3:
                    discardTableCard(card: card, player: &p3!)
                case .p4:
                    discardTableCard(card: card, player: &p4!)
            }
        }
    
        if card.hasCleanEffect {
            discartedCards.removeAll()
        }
    }
    
    func discardTableCard(card: Card, player: inout Player) {
        if(validateMove(card: card, player: player)){
            var tempCard = card
            tempCard.isFaceUp = true
            tempCard.isOnHand = true
            discartedCards.append(tempCard)
            cardToBeat = card
            cardToBeat.isFaceUp = true
            if(card.isFaceUp)
            {
                guard let index = player.faceUpCards.firstIndex(of: card) else { return }
                let newCard: Card? = player.faceDownCards.remove(at: index)
                if (newCard != nil) {
                    player.faceUpCards[index] = newCard!
                }
            }else {
                guard let index = player.faceUpCards.firstIndex(of: card) else { return }
                player.faceUpCards.remove(at: index)
                
            }
        }
    }
    
    func validateMove(card: Card, player: Player) -> Bool {
        var result = false
        if(card.isOnHand){
            result = true
        }
        else {
            if(card.isFaceUp){
                result = player.onHandCards.isEmpty
            }else{
                result = player.onHandCards.isEmpty && player.faceUpCards.isEmpty
            }
        }
        return result
    }
    
    func createPlayerWithCards(_ id: Int) throws -> Player{
        var player = Player(id: id)
        
        var randomCard = initialDeck.randomDrop()
        randomCard?.isFaceUp = true
        player.faceUpCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isFaceUp = true
        player.faceUpCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isFaceUp = true
        player.faceUpCards.append(randomCard!)
        
        randomCard = initialDeck.randomDrop()
        randomCard?.isOnHand = true
        randomCard?.isFaceUp = true
        player.onHandCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isOnHand = true
        randomCard?.isFaceUp = true
        player.onHandCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isOnHand = true
        randomCard?.isFaceUp = true
        player.onHandCards.append(randomCard!)
        
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        
        return player
    }
    
    // MARK: Accesors
    
    
    
//    func getFaceDownCards(_ player: Players) -> Array<Card> {
//        return players[player.rawValue].faceDownCards
//    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        
        switch player {
        case .p1:
            return p1?.faceUpCards ?? [Card]()
        case .p2:
            return p2?.faceUpCards ?? [Card]()
        case .p3:
            return p3?.faceUpCards ?? [Card]()
        case .p4:
            return p4?.faceUpCards ?? [Card]()
        }
    }
    
    func getCardsOnHand(_ player: Players) -> Array<Card> {
        
        switch player {
        case .p1:
            return p1?.onHandCards ?? [Card]()
        case .p2:
            return p2?.onHandCards ?? [Card]()
        case .p3:
            return p3?.onHandCards ?? [Card]()
        case .p4:
            return p4?.onHandCards ?? [Card]()
        }
        
    }
    
    func getCardsOnHand(_ player: Player) -> Array<Card> {
        return player.onHandCards
    }
    

}

//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation
import SwiftUI

final class PintoGame<CardContent>: ObservableObject where CardContent: Equatable {
    private var default_cards:[String] = [
        "U+1F0A1", "U+1F0A2", "U+1F0A3", "U+1F0A4", "U+1F0A5", "U+1F0A6", "U+1F0A7", "U+1F0A8", "U+1F0A9", "U+1F0AA", "U+1F0AB","U+1F0AD", "U+1F0AE",
        "U+1F0B1", "U+1F0B2", "U+1F0B3", "U+1F0B4", "U+1F0B5", "U+1F0B6", "U+1F0B7", "U+1F0B8", "U+1F0B9", "U+1F0BA", "U+1F0BB", "U+1F0BD", "U+1F0BE",
        "U+1F0C1", "U+1F0C2", "U+1F0C3", "U+1F0C4", "U+1F0C5", "U+1F0C6", "U+1F0C7", "U+1F0C8", "U+1F0C9", "U+1F0CA", "U+1F0CB", "U+1F0CD", "U+1F0CE",
        "U+1F0D1", "U+1F0D2", "U+1F0D3", "U+1F0D4", "U+1F0D5", "U+1F0D6", "U+1F0D7", "U+1F0D8", "U+1F0D9", "U+1F0DA", "U+1F0DB", "U+1F0DD", "U+1F0DE"]
    
    private(set) var initialDeck = Array<Card>()
    var discartedCards = Array<Card>()
    @Published private(set) var p1: Player?
    @Published private(set) var p2: Player?
    @Published private(set) var p3: Player?
    @Published private(set) var p4: Player?
    private var numberOfPlayers = 2
    private(set) var lastDiscarted: Card = Card.default
    var cardToBeat: Card = Card.default {
        willSet {
            objectWillChange.send()
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
        }
    }
    
    init() {
        startGame()
    }
    
    //MARK: Playabilty
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
    
    func moveToDiscarted(card: Card) {
        discartedCards.append(card)
    }
    
    func moveToDiscarted(card: Card, player: inout Player) {
        discartedCards.append(card)
        cardToBeat = card
        guard let index = getCardsOnHand(player).firstIndex(of: card) else { return }
        var newCard: Card? = initialDeck.remove(at: 0)
        if (newCard != nil) {
            newCard!.isFaceUp = true
            newCard!.isOnHand = true
            player.onHandCards[index] = newCard!
        }
    }
    
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
     This method is to select the initial card and make the respective user draw one card from the available cards
     */
    func selectMinimalCard() {
        #warning ("la carta mas pequena no se esta eliminando del respectivo arreglo. Y se le debe agregar otra nueva a las cartas en mano")
        var min = [Card]()
        for player in Players.allCases {
            switch player {
            case .p1:
                min.append(p1?.onHandCards.min { c1, c2 in c2.value > c1.value }! ?? Card.default)
            case .p2:
                min.append(p2?.onHandCards.min { c1, c2 in c2.value > c1.value }! ?? Card.default)
            case .p3:
                min.append(p3?.onHandCards.min { c1, c2 in c2.value > c1.value }! ?? Card.default)
            case .p4:
                min.append(p4?.onHandCards.min { c1, c2 in c2.value > c1.value }! ?? Card.default)
            }
        }
        cardToBeat = min.min(by: { c1, c2 in c2.value > c1.value })!
        cardToBeat.isFaceUp = true
    }
}

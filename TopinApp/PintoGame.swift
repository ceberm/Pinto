//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private var default_cards:[String] = [
        "U+1F0A1", "U+1F0A2", "U+1F0A3", "U+1F0A4", "U+1F0A5", "U+1F0A6", "U+1F0A7", "U+1F0A8", "U+1F0A9", "U+1F0AA", "U+1F0AB","U+1F0AD", "U+1F0AE",
        "U+1F0B1", "U+1F0B2", "U+1F0B3", "U+1F0B4", "U+1F0B5", "U+1F0B6", "U+1F0B7", "U+1F0B8", "U+1F0B9", "U+1F0BA", "U+1F0BB", "U+1F0BD", "U+1F0BE",
        "U+1F0C1", "U+1F0C2", "U+1F0C3", "U+1F0C4", "U+1F0BC5", "U+1F0C6", "U+1F0C7", "U+1F0C8", "U+1F0C9", "U+1F0CA", "U+1F0CB", "U+1F0CD", "U+1F0CE",
        "U+1F0D1", "U+1F0D2", "U+1F0D3", "U+1F0D4", "U+1F0BD5", "U+1F0D6", "U+1F0D7", "U+1F0D8", "U+1F0D9", "U+1F0DA", "U+1F0DB", "U+1F0DD", "U+1F0DE"]
    
    private(set) var initialDeck = Array<Card>()
    var discartedCards = Array<Card>()
    private(set) var players = Array<Player>()
    
    mutating func pick(card: Card){
        print("Card clicked! \(card)")
        //card.isFaceUp = true
    }
    
    init() {
        do {
            shuffleCards()
            try loadPlayers(4)
        }
        catch  {
            print("issue unexpected")
        }
        
    }
    
    mutating func loadPlayers(_ numberOfPlayers: Int) throws {
        if(numberOfPlayers >= 2){
            for num in 0..<numberOfPlayers {
                let player = try createPlayerWithCards(num)
                players.append(player)
            }
        } else {
            throw PintoModelError.invalidNumberOfPlayers
        }
    }
    
    mutating func loadNewPlayer(_ numberOfPlayers: Int) throws{
        players.append(Player(id: players.count))
    }
    
    func getFaceDownCards(_ player: Players) -> Array<Card> {
        return players[player.rawValue].faceDownCards
    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        return players[player.rawValue].faceUpCards
    }
    
    func getCardsOnHand(_ player: Players) -> Array<Card> {
        return players[player.rawValue].onHandCards
    }
    
    mutating func createPlayerWithCards(_ id: Int) throws -> Player{
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
        player.onHandCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isOnHand = true
        player.onHandCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        randomCard?.isOnHand = true
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
    mutating func shuffleCards(){
        default_cards.shuffle()
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
    }
}

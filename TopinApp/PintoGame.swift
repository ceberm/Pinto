//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private var default_cards:[String] = ["🂡", "🂢", "🂣", "🂤", "🂥", "🂦", "🂧", "🂨", "🂩", "🂪", "🂫",
                         "🂭", "🂮", "🂱", "🂲", "🂳", "🂴", "🂵", "🂶", "🂷", "🂸", "🂹", "🂺", "🂻", "🂽",
                         "🂾", "🃁", "🃂", "🃃", "🃄", "🃅", "🃆", "🃇", "🃈", "🃉", "🃊", "🃋", "🃍", "🃎",
                         "🃑", "🃒", "🃓", "🃔", "🃕", "🃖", "🃗", "🃘", "🃙", "🃚", "🃛", "🃝", "🃞"]
    
    private(set) var initialDeck = Array<Card>()
    private(set) var discartedCards = Array<Card>()
    private(set) var players = Array<Player>()
    private(set) var initialCard: Card?
    
    mutating func pick(card: Card){
        print("Card clicked! \(card)")
        //card.isFaceUp = true
    }
    
    init() {
        default_cards.shuffle()
        
        for cardIndex in 0..<default_cards.count {
            initialDeck.append(Card(id: cardIndex, content: default_cards[cardIndex]))
        }
        
        do {
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
            initialCard!.isFaceUp = true
            discartedCards.append(initialCard!)
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
        
        let minCard = player.onHandCards.min(by: { card1, card2 in
            card1.content < card2.content
        })
        
        if(initialCard == nil || minCard!.content < initialCard!.content){
            initialCard = minCard
        }
        
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        randomCard = initialDeck.randomDrop()
        player.faceDownCards.append(randomCard!)
        
        return player
    }
}

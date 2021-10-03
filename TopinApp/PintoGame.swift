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
    
    private var initialDeck = Array<Card>()
    private(set) var players = Array<Player>()
    
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
                players.append(Player(id: num, playerCards: try dealCardsForPlayer()))
            }
        } else {
            throw PintoModelError.invalidNumberOfPlayers
        }
    }
    
    mutating func loadNewPlayer(_ numberOfPlayers: Int) throws{
        players.append(Player(id: players.count, playerCards: try dealCardsForPlayer()))
    }
    
    func getFaceDownCards(_ player: Players) -> Array<Card> {
        switch player {
            case .p1:
                return players[0].playerCards.filter {!$0.isFaceUp}
            case .p2:
                return players[1].playerCards.filter {!$0.isFaceUp}
            case .p3:
                return players[2].playerCards.filter {!$0.isFaceUp}
            case .p4:
                return players[3].playerCards.filter {!$0.isFaceUp}
        }
    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        switch player {
            case .p1:
            return players[0].playerCards.filter {$0.isFaceUp && !$0.isOnHand}
            case .p2:
                return players[1].playerCards.filter {$0.isFaceUp && !$0.isOnHand}
            case .p3:
                return players[2].playerCards.filter {$0.isFaceUp && !$0.isOnHand}
            case .p4:
                return players[3].playerCards.filter {$0.isFaceUp && !$0.isOnHand}
        }
    }
    
    mutating func dealCardsForPlayer() throws -> Array<Card> {
        var cards = [Card]()
        for index in 0..<9 {
            if var randomCard = initialDeck.randomDrop() {
                if index < 6 {
                    randomCard.isFaceUp = true
                    if index > 2  {
                        randomCard.isOnHand = true
                    }
                }
                cards.append(randomCard)
            } else {
                throw PintoModelError.deckIsEmpty
            }
        }
        return cards
    }
}

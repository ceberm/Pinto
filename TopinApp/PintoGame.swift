//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private var default_cards:[String]? = ["🂡", "🂢", "🂣", "🂤", "🂥", "🂦", "🂧", "🂨", "🂩", "🂪", "🂫",
                         "🂭", "🂮","🂱", "🂲", "🂳", "🂴", "🂵", "🂶", "🂷", "🂸", "🂹", "🂺", "🂻", "🂽",
                         "🂾", "🃁", "🃂", "🃃", "🃄", "🃅", "🃆", "🃇", "🃈", "🃉", "🃊", "🃋", "🃍", "🃎",
                         "🃑", "🃒", "🃓", "🃔", "🃕", "🃖", "🃗", "🃘", "🃙", "🃚", "🃛", "🃝", "🃞"]
    
    private var initialDeck = Array<Card>()
    private(set) var player1 = Player(id: 1, playerCards: [Card]())
    private(set) var player2 = Player(id: 2, playerCards: [Card]())
    
    struct Card: Identifiable {
        var id: Int
        var content: String
        var isFaceUp: Bool = false
    }
    
    struct Player: Identifiable {
        var id: Int
        var playerCards: Array<Card>
    }
    
    mutating func pick(card: Card){
        print("Card clicked! \(card)")
        //card.isFaceUp = true
    }
    
    init() {
        default_cards?.shuffle()
        
        for cardIndex in 0..<default_cards!.count {
            initialDeck.append(Card(id: cardIndex, content: default_cards![cardIndex]))
        }
        
        default_cards = nil
        
        //Load last playing cards
        for _ in 0..<3 {
            var randomCardFaceUp = initialDeck.randomDrop()
            randomCardFaceUp.isFaceUp = true
            let randomCardFaceDown = initialDeck.randomDrop()
            player1.playerCards.append(randomCardFaceUp)
            player1.playerCards.append(randomCardFaceDown)
        }
        
    }
    
    func getFaceDownCards(_ player: Players) -> Array<Card> {
        switch player {
        case .p1:
            return player1.playerCards.filter {$0.isFaceUp == false}
        case .p2:
            return player2.playerCards.filter {$0.isFaceUp == false}
        default:
            return []
        }
    }
    
    func getFaceUpCards(_ player: Players) -> Array<Card> {
        switch player {
        case .p1:
            return player1.playerCards.filter {$0.isFaceUp}
        case .p2:
            return player2.playerCards.filter {$0.isFaceUp}
        default:
            return []
        }
    }
}

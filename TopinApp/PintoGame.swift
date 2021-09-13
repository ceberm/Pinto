//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private(set) var faceUpCards: Array<Card>
    private(set) var faceDownCards: Array<Card>
    var default_cards: [String]
    var initialDeck = Array<Card>()
    
    struct Card: Identifiable {
        var id: Int
        var content: String
        var isFaceUp: Bool = false
    }
    
    mutating func pick(card: Card){
        print("Card clicked! \(card)")
        //card.isFaceUp = true
    }
    
    init() {
        default_cards = ["🂡", "🂢", "🂣", "🂤", "🂥", "🂦", "🂧", "🂨", "🂩", "🂪", "🂫", "🂭", "🂮","🂱", "🂲", "🂳", "🂴", "🂵", "🂶", "🂷", "🂸", "🂹", "🂺", "🂻", "🂽", "🂾", "🃁", "🃂", "🃃", "🃄", "🃅", "🃆", "🃇", "🃈", "🃉", "🃊", "🃋", "🃍", "🃎", "🃑", "🃒", "🃓", "🃔", "🃕", "🃖", "🃗", "🃘", "🃙", "🃚", "🃛", "🃝", "🃞"]
        faceUpCards = Array<Card>()
        faceDownCards = Array<Card>()
        
        default_cards.shuffle()
        
        for cardIndex in 0..<default_cards.count {
            initialDeck.append(Card(id: cardIndex, content: default_cards[cardIndex]))
        }
        
        for _ in 0..<3 {
            var randomCardFaceUp = initialDeck.randomElementRemoval()
            randomCardFaceUp.isFaceUp = true
            let randomCardFaceDown = initialDeck.randomElementRemoval()
            faceUpCards.append(randomCardFaceUp)
            faceDownCards.append(randomCardFaceDown)
        }
        
    }
}

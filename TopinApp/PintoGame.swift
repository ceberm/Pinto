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
        for cardIndex in 0..<default_cards.count {
            let content = default_cards[cardIndex]
            let content2 = default_cards[cardIndex]
            faceUpCards.append(Card(id: cardIndex, content: content, isFaceUp: true))
            faceDownCards.append(Card(id: cardIndex+1, content: content2))
        }
        //cards.shuffle()
    }
}

//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    //private(set) var themes
    
    struct Card: Identifiable {
        var id: Int
        var content: String
        var isFaceUp: Bool = false
    }
    
    func pick(card: Card){
        print("Card clicked! \(card)")
    }
    
    init() {
        cards = Array<Card>()
        let defaultCards = ["🂢", "🂣", "🂤", "", "🂧", "🃋", "🃎", "🂸", "🂾", "🃁", ]
        for cardIndex in 0..<defaultCards.count {
            let content = defaultCards[cardIndex]
            cards.append(Card(id: cardIndex, content: content))
        }
        //cards.shuffle()
    }
}

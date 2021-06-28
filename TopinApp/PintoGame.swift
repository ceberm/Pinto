//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import Foundation

struct PintoGame<CardContent> where CardContent: Equatable {
    private(set) var p1Cards: Array<Card>
    private(set) var p2Cards: Array<Card>
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
        p1Cards = Array<Card>()
        p2Cards = Array<Card>()
        let defaultCards = ["🂢", "🂣", "🂤"]
        let defaultCards2 = ["🂸", "🂾", "🃁"]
        // "🂧", "🃋", "🃎", "🂸", "🂾", "🃁", 
        for cardIndex in 0..<defaultCards.count {
            let content = defaultCards[cardIndex]
            let content2 = defaultCards2[cardIndex]
            p1Cards.append(Card(id: cardIndex, content: content))
            p2Cards.append(Card(id: cardIndex+1, content: content2))
        }
        //cards.shuffle()
    }
}

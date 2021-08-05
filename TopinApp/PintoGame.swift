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
    
    struct Card: Identifiable {
        var id: Int
        var content: String
        var isFaceUp: Bool = false
    }
    
    func pick(card: Card){
        print("Card clicked! \(card)")
    }
    
    init() {
        faceUpCards = Array<Card>()
        faceDownCards = Array<Card>()
        let default_faceUpCards = ["🃒", "🂣", "🂤"]
        let default_faceDownCards = ["🂸", "🂾", "🃁"]
        // "🂧", "🃋", "🃎", "🂸", "🂾", "🃁", 🂠 🃒 🂢
        for cardIndex in 0..<default_faceDownCards.count {
            let content = default_faceUpCards[cardIndex]
            let content2 = default_faceDownCards[cardIndex]
            faceUpCards.append(Card(id: cardIndex, content: content, isFaceUp: true))
            faceDownCards.append(Card(id: cardIndex+1, content: content2))
        }
        //cards.shuffle()
    }
}

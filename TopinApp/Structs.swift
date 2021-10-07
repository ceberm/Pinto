//
//  Structs.swift
//  TopinApp
//
//  Created by Cesar on 2/10/21.
//

import Foundation

struct Card: Identifiable {
    var id: Int
    var content: String
    var isFaceUp: Bool = false
    var isOnHand: Bool = false
}


struct Player: Identifiable {
    var id: Int
    var faceUpCards: Array<Card> = []
    var faceDownCards: Array<Card> = []
    var onHandCards: Array<Card> = []
}

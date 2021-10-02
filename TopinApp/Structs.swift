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
}


struct Player: Identifiable {
    var id: Int
    var playerCards: Array<Card>
}

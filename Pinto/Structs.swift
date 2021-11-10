//
//  Structs.swift
//  TopinApp
//
//  Created by Cesar on 2/10/21.
//

import Foundation

struct Card: Identifiable, Equatable, Hashable {
    var id: Int
    var content: String
    var isFaceUp: Bool = false
    var isOnHand: Bool = false
    var hasReverseEffect: Bool = false
    var hasCleanEffect: Bool = false
    var hasOnlyGreatersEffect: Bool = false
    var hasOnlySmallsEffect: Bool = false
    var value: Int
    
    ///This is a source of truth
    static let `default` = Card(id: -1, content: "", value: 1000)
}


struct Player: Identifiable {
    var id: Int
    var faceUpCards: Array<Card> = []
    var faceDownCards: Array<Card> = []
    var onHandCards: Array<Card> = []
    
    static let `default` = Player(id: 0)
}

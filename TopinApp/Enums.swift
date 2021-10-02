//
//  Enums.swift
//  TopinApp
//
//  Created by Cesar on 13/9/21.
//

import Foundation

enum Players {
    case p1, p2, p3, p4
}

enum PintoModelError: Error {
    case invalidNumberOfPlayers
    case deckIsEmpty
}

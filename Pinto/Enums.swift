//
//  Enums.swift
//  TopinApp
//
//  Created by Cesar on 13/9/21.
//

import Foundation

enum Players: Int {
    case p1 = 0, p2 = 1, p3 = 2, p4 = 3
}

enum PintoModelError: Error {
    case invalidNumberOfPlayers
    case deckIsEmpty
}

//
//  Enums.swift
//  TopinApp
//
//  Created by Cesar on 13/9/21.
//

import Foundation

enum Players: Int, CaseIterable {
    case p1 = 1, p2 = 2, p3 = 3, p4 = 4
}

enum PintoModelError: Error {
    case invalidNumberOfPlayers
    case deckIsEmpty
}

//
//  PintoGame.swift
//  TopinApp
//
//  Created by Cesar on 26/6/21.
//

import SwiftUI

///View Model
class PintoCardGame: ObservableObject {
    @Published private var model: PintoGame<String> = createPintoGame()
    private var currentColor: Color?
    
    private static func createPintoGame() -> PintoGame<String>{
        return PintoGame<String>()
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<PintoGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Inten(s)
    
    func chooseCard(card: PintoGame<String>.Card){
        model.pick(card: card)
    }
}

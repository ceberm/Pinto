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
    
    var p1Cards: Array<PintoGame<String>.Card>{
        model.p1Cards
    }
    
    var p2Cards: Array<PintoGame<String>.Card>{
        model.p2Cards
    }
    
    //MARK: - Inten(s)
    
    func chooseCard(card: PintoGame<String>.Card){
        model.pick(card: card)
    }
}

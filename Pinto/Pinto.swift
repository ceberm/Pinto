//
//  TopinApp.swift
//  TopinApp
//
//  Created by Cesar on 13/6/21.
//

import SwiftUI

@main
struct Pinto: App {
    var body: some Scene {
        WindowGroup {
            GameView().environmentObject(PintoGame<String>())
        }
    }
}

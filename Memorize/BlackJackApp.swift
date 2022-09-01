//
//  MemorizeApp.swift
//  Memorize
//
//  Created by user220730 on 8/16/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = BlackJackGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

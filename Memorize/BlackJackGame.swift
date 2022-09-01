//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user220730 on 8/19/22.
//

import SwiftUI



class BlackJackGame: ObservableObject{
    
    
    static func createBlackJackGame() -> BlackJack<String> {
        return BlackJack<String>()
    }
    func deal(){
        
        model.deal()
    }
    func pass(){
        model.pass()
    }
    func newGame(){
        model.newGame()
    }
    
    @Published private var model: BlackJack<String> = createBlackJackGame()
    
    var cards: Array<BlackJack<String>.Card>{
        return model.cards
        
    }
    var dealerCards: Array<BlackJack<String>.Card>{
        return model.dealerCards
        
    }
    var playerCards: Array<BlackJack<String>.Card>{
        return model.playerCards
        
    }
    var gameOver: Bool{
        return model.gameOver
        
    }
    var playerCount: Int{
        return model.countRank(cards: model.playerCards)
        
    }
    var dealerCount: Int{
        return model.countRank(cards: model.dealerCards)
        
    }
    var gameSummary: String{
        return model.gameSummary
        
    }
    //MARK: -Intent(s)
    
   
}

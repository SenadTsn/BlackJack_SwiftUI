//
//  MemoryGame.swift
//  Memorize
//
//  Created by user220730 on 8/19/22.
//

import Foundation

struct BlackJack<CardContent> where CardContent :Equatable {
    private(set)var cards: Array<Card>
    private(set) var playerCards: Array<Card>
    private(set) var dealerCards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard:Int?
    private(set) var gameOver : Bool = false
    private(set) var gameSummary : String = ""
    private(set) var passed : Bool = false

        
    
    init(){
        cards = Array<Card>()
        playerCards = Array<Card>()
        dealerCards = Array<Card>()
        cards = createDeck()
        playerCards.append(cards.removeLast())
        dealerCards.append(cards.removeLast())
        playerCards.append(cards.removeLast())
        dealerCards.append(cards.removeLast())
        dealerCards[dealerCards.count - 1].isFaceUp = false
        
    }
    mutating func deal(){
        let card = cards.removeLast()
        playerCards.append(card)
        checkWinner()
    }
    func countRank(cards : Array<Card>) -> Int{
        var sum : Int = 0
        var countAces = 0
        for card in cards{
            if card.isFaceUp{
                
                sum += min(card.rank, 10)
                if card.rank == 1 {
                    countAces+=1
                    
                }
            }
            
            
        }
        if sum + countAces * 10 <= 21 {
            sum += countAces * 10
        }
        return sum
    }
    mutating func checkWinner(){
        var playerTot = countRank(cards: playerCards)
        var dealerTot = countRank(cards: dealerCards)
        gameOver = true
        if playerTot == 21 && dealerTot != 21{
            gameSummary = "BLACKJACK - Player won"
        }
        else if playerTot > 21 {
            gameSummary = "Player Lost"
        }
        else if dealerTot > 21 {
            gameSummary = "Dealer Lost"
        }
        else if playerTot < 21 && playerTot > dealerTot && passed {
            gameSummary = "Player Won, higher Number"
        }
        else if dealerTot < 21 && dealerTot > playerTot && passed {
            gameSummary = "Dealer won, higher Number"
        }
        else if playerTot ==  dealerTot && passed{
            gameSummary = "Equal, Dealer won"
        }
        else if dealerTot == 21{
            gameSummary = "BLACKJACK - Dealer won"
        }
        else{
            gameOver = false
        }
        if gameOver {
            dealerCards[dealerCards.count - 1].isFaceUp = true
        }
    }
    mutating func pass(){
        dealerCards[dealerCards.count - 1].isFaceUp = true
        while countRank(cards: dealerCards) <= 16 {
            dealerCards.append(self.cards.removeLast())
        }
        passed = true
        checkWinner()
    }
    mutating func newGame(){
        gameSummary = ""
        passed = false
        gameOver = false
        cards = Array<Card>()
        playerCards = Array<Card>()
        dealerCards = Array<Card>()
        cards = createDeck()
        playerCards.append(cards.removeLast())
        dealerCards.append(cards.removeLast())
        playerCards.append(cards.removeLast())
        dealerCards.append(cards.removeLast())
        dealerCards[dealerCards.count - 1].isFaceUp = false
                
    }
    func createDeck() -> [Card]{
        let suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
        
        var emptyDeck: [Card] = []
        
        for suit in suits {
            for rank in 1...13{
                let newCard = Card(rank: rank, suit: suit)
                    emptyDeck.append(newCard)
            }
        }
        emptyDeck.shuffle()
        return emptyDeck
    }
    
    
    /*struct Card2  {
        //var isFaceUp : Bool = false
        var rank: Int
        var suit : String
        //var id : Int
    }*/
    struct Card : Identifiable {
        var isFaceUp : Bool = true
        var rank: Int
        var suit : String
        var id = UUID()
    }
}

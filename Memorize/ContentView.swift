//
//  ContentView.swift
//  Memorize
//
//  Created by user220730 on 8/16/22.
//

import SwiftUI

struct ContentView: View {
  
 
    
    @ObservedObject var viewModel:BlackJackGame
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Dealer")
                }
                ScrollView{
                    LazyVGrid(columns:[GridItem(.adaptive(minimum: 65))]){
                        ForEach(viewModel.dealerCards){ card in
                            CardView(card:card)
                                .aspectRatio(2/3,contentMode: .fit)
                            
                        }
                    }
                }
                HStack{
                    Text("Player")
                }
                ScrollView{
                    LazyVGrid(columns:[GridItem(.adaptive(minimum: 65))]){
                        ForEach(viewModel.playerCards){ card in
                            CardView(card:card)
                                .aspectRatio(2/3,contentMode: .fit)
                            
                        }
                    }
                }
                HStack(spacing: 50){
                    Text(viewModel.gameSummary)
                }
                Spacer()
                HStack(spacing: 50){
                    Text("Player: " + String(viewModel.playerCount))
                    Text("Dealer: " + String(viewModel.dealerCount))

                }
                Spacer()
                HStack{
                    if viewModel.gameOver {
                        newGame
                    }
                    else{
                        addCard
                        passCard
                    }
                    
                      
                }.padding(.horizontal)
            }
            .padding(.horizontal)
            .foregroundColor(.red)
            .navigationBarTitle("BlackJack")
                        
        }
        
    }
    var addCard: some View{
        Button(action:{
            viewModel.deal()
        },label:{VStack{
            Text("Deal")
                .font(.largeTitle)
            
            }} )
    }
    var passCard: some View{
        Button(action:{
            viewModel.pass()
            
        },label:{VStack{
            Text("Pass")
                .font(.largeTitle)
            
            }} )
    }
    var newGame: some View{
        Button(action:{
            viewModel.newGame()
            
        },label:{VStack{
            Text("New Game")
                .font(.largeTitle)
            
            }} )
    }
    
}
func getImageForCard(card: BlackJack<String>.Card ) -> String{
    if card.isFaceUp == false {
        return "card_back"
    }
    if card.rank >= 10 {
        return card.suit + String(card.rank)
    }
    else{
        return card.suit + "0" + String(card.rank)
    }
}
struct CardView : View{
    
    let card: BlackJack<String>.Card
    var body: some View{
        ZStack{
            Image(getImageForCard(card: card)).resizable()
            
               
        }
        
    }
}





















































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = BlackJackGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}


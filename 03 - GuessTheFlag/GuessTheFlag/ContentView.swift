//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by nicolas.e.manograsso on 06/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .green, location: 0.3), .init(color: .init(uiColor: .systemBackground), location: 0.3)], center: .top, startRadius: 240, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Text("Tap the flag of \(countries[correctAnswer])").bold().padding()
                
                ForEach(0..<3) { index in
                    Button(){
                        onFlagTapped(index)
                    } label: {
                        Image(countries[index])
                    }.cornerRadius(20)
                        .shadow(color: .primary, radius: 2)
                    
                }
            }
        }.alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: shuffled)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func onFlagTapped(_ index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct 🎉"
            score += 1
        } else {
            scoreTitle = "Wrong 🥲"
        }
        
        showScore.toggle()
    }
    
    func shuffled() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

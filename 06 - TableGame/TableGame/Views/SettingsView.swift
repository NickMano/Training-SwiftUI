//
//  ContentView.swift
//  TableGame
//
//  Created by nicolas.e.manograsso on 28/11/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var questionsCount = 5
    @State private var table = 2
    @State private var showingSheet = false
    
    var tableText: String {
        table == 2 ? "Table of 2" : "Table of 2 to \(table)"
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(.brown)
                .ignoresSafeArea()
            
            VStack {
                Image("owl")
                
                Text("Tables")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    
                VStack {
                    Stepper(tableText,
                            value: $table,
                            in: 2...12)
                    .foregroundColor(.white)
                    .padding()
                    
                    Stepper("\(questionsCount) questions",
                            value: $questionsCount,
                            in: 5...20,
                            step: 5)
                    .foregroundColor(.white)
                    .padding()
                }.padding(.vertical, 80)
                
                Button("Play") {
                    showingSheet.toggle()
                }.principal()
            }
            .padding()
            .sheet(isPresented: $showingSheet) {
                GameView(questions: questionsCount, table: table)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

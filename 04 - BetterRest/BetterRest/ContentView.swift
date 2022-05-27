//
//  ContentView.swift
//  BetterRest
//
//  Created by nicolas.e.manograsso on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(String(format: "%.2f", sleepAmount)) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by nicolas.e.manograsso on 04/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Group {
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
            }
            
            Section {
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

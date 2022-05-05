//
//  ContentView.swift
//  WeSplit
//
//  Created by nicolas.e.manograsso on 04/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    let currency = Locale.current.currencyCode ?? "USD"
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmountToPay: Double {
        let totalPerson = Double(numberOfPeople + 2)
        return (checkAmount + tipValue) / totalPerson
    }
    
    var tipValue: Double {
        checkAmount * Double(tipPercentage) / 100.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmountToPay, format: .currency(code: currency))
                }
            }.navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

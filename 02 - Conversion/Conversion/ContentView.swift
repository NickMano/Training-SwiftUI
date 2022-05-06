//
//  ContentView.swift
//  Conversion
//
//  Created by nicolas.e.manograsso on 05/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 0.0
    @State private var tempFrom: UnitTemperature = .celsius
    @State private var tempTo: UnitTemperature = .fahrenheit
    
    private let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    var tempFinal: Double {
        let t = Measurement(value: temperature, unit: tempFrom)
        return t.converted(to: tempTo).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                    
                    Picker("From", selection: $tempFrom) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    Picker("To", selection: $tempTo) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    
                    Text("\(tempFinal, specifier: "%.2f") \(tempTo.symbol)")
                } header: {
                    Text("Temparature")
                }
            }.navigationTitle("Unit Convertion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

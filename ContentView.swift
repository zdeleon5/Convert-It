//
//  ContentView.swift
//  Convert It
//
//  Created by Zinedine De Leon on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var userInput: String = "0.0"
    // UnitLength class alllows for easier/more accurate acesss to measurement units
    @State var inputUnit: UnitLength = .meters
    @State var outputUnit: UnitLength = .meters
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    // computed property to find value of conversion
    var convertedValue: Double {
        // nil coalescing to confirm either a user input or the defualt 0.0
        let inputValue = Double(userInput) ?? 0.0
        // Measurement provides a API for conversion and calculation takes value and input
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
        // Measurement converted method to change unit
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        // return using Measurement API .value
        return outputMeasurement.value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Starting Value", text: $userInput)
                        .keyboardType(.decimalPad)
                }
                header: {
                    Text("Starting Value")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.zero)
                        .foregroundStyle(.gray)
                }
                
                Section {
                    Picker("Input Units", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {unit in
                            Text(unit.symbol)
                        }
                    }
                } header: {
                    Text("Units")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.zero)
                        .foregroundStyle(.gray)
                }
                
                Section {
                    // returns remainder of the operation
                    convertedValue.truncatingRemainder(dividingBy: 1) == 0 ? Text("\(Int(convertedValue))") : Text("\(convertedValue, specifier: "%.3f")")
                } header: {
                    Text("Ending Value")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.zero)
                        .foregroundStyle(.gray)
                }
            }
        }
        .navigationTitle("Convert It!" )
    }
}

    
    #Preview {
        ContentView()
    }

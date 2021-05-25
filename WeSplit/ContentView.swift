//
//  ContentView.swift
//  WeSplit
//
//  Created by Seth Corker on 23/05/2021.
//

import SwiftUI

let baseNumberOfPayers = 2

struct ContentView: View {
    @State private var billAmount = ""
    @State private var numberOfPayersIndex = 0
    @State private var tipPercentageIndex = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var currencySymbol: String {
        return Locale.current.currencySymbol ?? "$"
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentageIndex])
        let amount = Double(billAmount) ?? 0
        
        let tipValue = amount / 100 * tipSelection
        return amount + tipValue
    }
    
    var totalPerPayer: Double {
        let payerCount = Double(numberOfPayersIndex + baseNumberOfPayers)
        return grandTotal / payerCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $billAmount)
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                    
                    
                    Picker("Number of people", selection: $numberOfPayersIndex) {
                        ForEach(baseNumberOfPayers ..< 51) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section(header: Text("How much do you want to leave for a tip?")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total with tip")) {
                    Text("\(currencySymbol)\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("\(currencySymbol)\(totalPerPayer, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BillApp
//
//  Created by Franco Ruiz on 06/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var totalBillInput: String = ""
    @State private var tipPercentageIndex: Int = 1
    @State private var numberOfPeople: Int = 1
    
    let tipOptions = [0, 10, 15, 20]
    var totalBill: Double {
        return Double(totalBillInput) ?? 0
    }
    
    var tipAmount: Double {
        let percentage = Double(tipOptions[tipPercentageIndex])
        return totalBill * (percentage / 100)
    }
    
    var totalWithTip: Double {
        return totalBill + tipAmount
    }
    
    var billPerPerson: Double {
        return totalBill / Double(numberOfPeople)
    }
    
    var tipPerPerson: Double {
        return tipAmount / Double(numberOfPeople)
    }
    
    var totalPerPerson: Double {
        return totalWithTip / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        Text("Bill Total")
                            .font(.title)
                        
                        TextField("$", text: $totalBillInput)
                            .keyboardType(.decimalPad)
                            .font(.largeTitle)
                            .padding()
                            .background(Color(.white))
                            .border(.gray)
                        VStack(alignment: .leading) {
                            Text("Tip Percentage")
                            Picker("Tip Percentage", selection: $tipPercentageIndex) {
                                ForEach(0..<tipOptions.count, id: \.self) { index in
                                    Text("\(tipOptions[index])%")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Number of People")
                            HStack {
                                Text("\(numberOfPeople)")
                                    .font(.title2)
                                Spacer()
                                Stepper("", value: $numberOfPeople, in: 1...10)
                                    .labelsHidden()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding()
                    
                    VStack(spacing: 15) {
                        ForEach(0..<numberOfPeople, id: \.self) { index in
                            PersonCard(
                                index: index + 1,
                                billPortion: billPerPerson,
                                tipPortion: tipPerPerson,
                                total: totalPerPerson
                            )
                        }
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color(.white))
        }
    }
}

#Preview {
    ContentView()
}

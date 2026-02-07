//
//  PersonCard.swift
//  BillApp
//
//  Created by Franco Ruiz on 06/02/26.
//

import SwiftUI

struct PersonCard: View {
    let index: Int
    let billPortion: Double
    let tipPortion: Double
    let total: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Person \(index)")
                .font(.headline)
            
            HStack{
                VStack(alignment: .leading, spacing: 8){
                    Text("Bill: \(String(format: "$%.2f", billPortion))")
                        .font(.headline)
                    Text("Tip: \(String(format: "$%.2f", tipPortion))")
                        .font(.headline)
                    Divider()
                    Text("Total: \(String(format: "$%.2f", total))")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    PersonCard(index: 1, billPortion: 40.00, tipPortion: 6.00, total: 46.00)
        .padding()
}

//
//  ContentView.swift
//  SwiftUI1App
//
//  Created by Franco Ruiz on 31/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CircleImage()
            Text("Pikachu")
                .font(.largeTitle)

            
            HStack {
                Text("#25")
                Spacer() //Toma el espacio disponible
                Text("Electrico")

            }
            .border(.red)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

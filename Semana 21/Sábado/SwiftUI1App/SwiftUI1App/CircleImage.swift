//
//  CircleImage.swift
//  SwiftUI1App
//
//  Created by Franco Ruiz on 31/01/26.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("pika")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .clipShape(.circle)
            .border(.blue, width: 2)
    }
}

#Preview {
    CircleImage()
}

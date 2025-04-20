//
//  SpicinessMeter.swift
//  Challenge1
//
//  Created by Komang Wikananda on 14/04/25.
//

import SwiftUI

public struct SpicinessCard: View {
    var spiciness = 3
    
    let colors: [Color] = [.spicy0, .spicy0, .spicy2, .spicy3, .spicy4, .spicy5, .spicy6, .spicy7, .spicy8, .spicy9, .spicy10]
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Text(String(spiciness))
                .frame(maxHeight: .infinity, alignment: .top)
                .font(.system(size: 128, weight: .bold))
                .foregroundColor(.white)
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [colors[spiciness].opacity(1), colors[spiciness].opacity(0.7), colors[spiciness].opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxHeight: 150, alignment: .bottomLeading)
        }
        .frame(width: 170, height: 200)
        .background(colors[spiciness])
        .cornerRadius(20)
    }
}

#Preview {
    SpicinessCard()
}

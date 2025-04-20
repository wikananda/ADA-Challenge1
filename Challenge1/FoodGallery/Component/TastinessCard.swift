//
//  TastinessMeter.swift
//  Challenge1
//
//  Created by Komang Wikananda on 14/04/25.
//

import SwiftUI

public struct TastinessCard: View {
    var tastiness = 3
    let tastinessLevels: [String] = ["URGH...!", "uh...", "okay...", "Tasty!", "AWESOMEE!"]
    let colors: [Color] = [.tasty0, .tasty1, .tasty2, .tasty3, .tasty4]
    let fontWeight: [Font.Weight] = [.black, .regular, .medium, .bold, .heavy]
    
    public var body: some View {
        ZStack {
            VStack(spacing: 5) {
                Image(systemName: "face.smiling.inverse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                Text(tastinessLevels[tastiness])
                    .font(.system(size: 48, weight: fontWeight[tastiness]))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 170, height: 200)
        .background(colors[tastiness])
        .cornerRadius(20)
    }
}

#Preview {
    TastinessCard()
}

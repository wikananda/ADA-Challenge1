//
//  LevelUpView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 19/04/25.
//

import SwiftUI

struct LevelUpView: View {
    var isLevelUp: Bool = false
    var currentLevel: Int = 5
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            if (isLevelUp) {
                Image(.flameFill)
                    .foregroundColor(spicyColors[currentLevel + 1])
                    .shadow(
                        color: spicyColors[currentLevel + 1].opacity(0.5),
                        radius: 12,
                        x: 0,
                        y: 12
                    )
                Text("Level \(currentLevel + 1)!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(spicyColors[currentLevel + 1])
                
                (
                    Text("Yohoo! You now ")
                    + Text("level \(currentLevel + 1)").fontWeight(.bold)
                    + Text("! \nKeep goin!")
                )
                .frame(maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            } else {
                Image(.flameFill)
                    .foregroundColor(spicyColors[currentLevel])
                    .shadow(
                        color: spicyColors[currentLevel].opacity(0.5),
                        radius: 12,
                        x: 0,
                        y: 12
                    )
                Text("Level \(currentLevel)...")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(spicyColors[currentLevel])
                
                Text("Hmm? Looks like you did not level up...?")
                    .frame(maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            }
            
            Spacer().frame(height: 250)
            
            Button(action: Back) {
                Label("Ok", systemImage: "checkmark")
            }
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: 250)
            .background(.orangeish)
            .clipShape(Capsule())
            .shadow(
                color: .orangeish.opacity(0.35),
                radius: 12,
                x: 0,
                y: 12
            )
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 100)
    }
}

func Back() {
    
}

#Preview {
    LevelUpView()
}

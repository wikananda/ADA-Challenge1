//
//  LevelUpView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 19/04/25.
//

import SwiftUI
import SwiftData

struct LevelUpView: View {
    @Environment(\.modelContext) private var context
    var isLevelUp: Bool = false
    var onOk: (() -> Void)? = nil
    @Query private var users: [UserData]
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            let user = users.first
            let currentLevel = user?.level ?? 2
            if (isLevelUp) {
                Image(.flameFill)
                    .foregroundColor(spicyColors[currentLevel])
                    .shadow(
                        color: spicyColors[currentLevel].opacity(0.5),
                        radius: 12,
                        x: 0,
                        y: 12
                    )
                Text("Level \(currentLevel)!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(spicyColors[currentLevel])
                
                (
                    Text("Yohoo! You now ")
                    + Text("level \(currentLevel)").fontWeight(.bold)
                    + Text("! \nKeep goin!")
                )
                .frame(maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .onAppear {
                    user?.levelUp()
                    user?.resetSpicyCount()
                    try? context.save()
                }
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
            
            Button(action: { onOk?() }) {
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


#Preview {
    LevelUpView()
}

//
//  ProgressView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 17/04/25.
//

import SwiftUI

struct SpicyChallengeView: View {
    @State private var progress: Double = 0.8
    @State private var spicyLevel: Int = 5
    @State private var spicyCount: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(spacing: 20) {
                Image(.flameFill)
                    .foregroundColor(spicyColors[spicyLevel])
                    .shadow(
                        color: spicyColors[spicyLevel].opacity(0.5),
                        radius: 12,
                        x: 0,
                        y: 12
                    )
                Text("Level \(spicyLevel)")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(spicyColors[spicyLevel])
                CapsuleProgressView(progress: progress, color: spicyLevel < 9 ? spicyColors[spicyLevel + 1] : spicyColors[9])
                if (progress < 1.0) {
                    Group {
                        Text("Eat ") + Text("\(spicyCount)").fontWeight(.heavy) + Text(" spicy food") + Text(" level \(spicyLevel) or more").fontWeight(.heavy) + Text(" to level up!")
                    }
                    .frame(maxWidth: 250)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                } else {
                    Group {
                        Text("You are now ready! ") + Text("Finish your challenge").fontWeight(.heavy) + Text(" to level up!")
                    }
                    .frame(maxWidth: 250)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack (alignment: .leading, spacing: 20) {
                Text("Your Next Challenge")
                    .font(.system(size: 16, weight: .bold))
                ChallengeCard()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}


// MARK: - CUSTOM PROGRESS VIEW
struct CapsuleProgressView: View {
    var progress: Double
    var color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: 250, height: 20)
                .foregroundColor(Color.gray.opacity(0.2))
            LinearGradient(
                gradient: Gradient(colors: [.spicy0, color]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 250 * progress, height: 20)
            .clipShape(Capsule())
            .shadow(
                color: color.opacity(0.5),
                radius: 12,
                x: 0,
                y: 5
            )
        }
    }
}

#Preview {
    SpicyChallengeView()
}

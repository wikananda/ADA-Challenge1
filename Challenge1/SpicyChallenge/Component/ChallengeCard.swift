//
//  ChallengeCard.swift
//  Challenge1
//
//  Created by Komang Wikananda on 18/04/25.
//

import SwiftUI

struct ChallengeCard : View {
    var foodName: String = "Nasi Goreng"
    var location: String = "Warung Indo"
    var spicyLevel: Int = 3
    
    var body: some View {
        HStack (spacing: 20) {
            Image(.food0)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 110, height: 110, alignment: .leading)
                .clipped()
                .cornerRadius(20)
            VStack (alignment: .leading, spacing: 10) {
                Text(foodName)
                    .font(.system(size: 16, weight: .bold))
                Label(location, systemImage: "location.circle.fill")
                Label {
                    Text(String(spicyLevel))
                } icon: {
                    Image("flame.fill")
                        .resizable()
                        .frame(width: 16, height: 20)
                }
                .foregroundColor(.orangeish)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 130, alignment: .leading)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ChallengeCard()
}

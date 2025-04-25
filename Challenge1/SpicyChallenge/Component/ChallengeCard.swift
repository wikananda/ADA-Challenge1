//
//  ChallengeCard.swift
//  Challenge1
//
//  Created by Komang Wikananda on 18/04/25.
//

import SwiftUI

struct ChallengeCard : View {
    var food: FoodData
//    var foodName: String = "Nasi Goreng"
//    var location: String = "Warung Indo"
//    var spicyLevel: Int = 3
    private var img: UIImage {
        if let uiImage = loadImageFromDocuments(fileName: food.img) {
            return uiImage
        }
        return UIImage(resource: .food0)
    }
    
    var body: some View {
        HStack (spacing: 20) {
            Image(uiImage: img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 110, height: 110, alignment: .leading)
                .clipped()
                .cornerRadius(20)
            VStack (alignment: .leading, spacing: 10) {
                Text(food.name)
                    .font(.system(size: 16, weight: .bold))
                Label(food.location, systemImage: "location.circle.fill")
                Label {
                    Text(String(food.spiciness))
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
    ChallengeCard(food: dummyFood)
}

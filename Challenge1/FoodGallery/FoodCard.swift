//
//  FoodCard.swift
//  Challenge1
//
//  Created by Komang Wikananda on 11/04/25.
//

import SwiftUI

struct FoodCard: View {
    var img: String = "food_0"
    var name: String = "Food Name"
    var location: String = "Location"
    var spiciness: Int = 0
    
//    private let height: CGFloat = CGFloat.random(in: 175...290)
    
    private var height: CGFloat {
        let seed = name.hashValue
        let random = CGFloat(abs(seed % 115))
        return 175 + random
    }
    
    // For vertical case
//    var vertical: Bool = true
//    var height: CGFloat {
//        vertical ? 290 : 175
//    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(img)
                .resizable()
//                    .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(width: 175, height: height)
                .cornerRadius(20)
            
            ZStack(alignment: .bottom) {
                // BG Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Label Contents
                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.white)
                    
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color.white)
                        Text(location)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.white)
                    }
                    
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.red)
                        Text(String(spiciness))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            .frame(maxHeight: (height / 2 + 20))
            .cornerRadius(20)
        }
        .frame(maxWidth: 175)
    }
}

#Preview {
    FoodCard()
}

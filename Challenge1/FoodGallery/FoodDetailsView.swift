//
//  FoodDetailsView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 14/04/25.
//

import SwiftUI

struct FoodDetailsView: View {
    var img: String = "food_0"
    var title: String = "Food Name"
    var date: String = "Jun 10, 2024"
    var time: String = "12:00 PM"
    var location: String = "Warung Indo"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    Text("\(date) (\(time))")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                        Text("\(location)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 10)
                    
                    HStack {
                        TastinessCard()
                        Spacer()
                        SpicinessCard()
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    FoodDetailsView()
}

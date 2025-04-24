//
//  ContentView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 11/04/25.
//

import SwiftUI
import SwiftData

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let spiciness: Int
    let img: String
}

struct FoodGalleryView: View {
//    let foodItems = [
//        FoodItem(name: "Nasi Goreng", location: "Warung Bali", spiciness: 3, img: "food_0"),
//        FoodItem(name: "Sate Ayam", location: "Pasar Malam", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Rendang", location: "Rumah Padang", spiciness: 4, img: "food_0"),
//        FoodItem(name: "Gado-gado", location: "Warung Jawa", spiciness: 1, img: "food_0"),
//        FoodItem(name: "Bakso", location: "Gerobak Pak Tono", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Soto Ayam", location: "Kedai Soto", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Mie Goreng", location: "Warung Pinggir Jalan", spiciness: 3, img: "food_0"),
//        FoodItem(name: "Ayam Betutu", location: "Resto Bali", spiciness: 5, img: "food_0"),
//        FoodItem(name: "Nasi Goreng", location: "Warung Bali", spiciness: 3, img: "food_0"),
//        FoodItem(name: "Sate Ayam", location: "Pasar Malam", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Rendang", location: "Rumah Padang", spiciness: 4, img: "food_0"),
//        FoodItem(name: "Gado-gado", location: "Warung Jawa", spiciness: 1, img: "food_0"),
//        FoodItem(name: "Bakso", location: "Gerobak Pak Tono", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Soto Ayam", location: "Kedai Soto", spiciness: 2, img: "food_0"),
//        FoodItem(name: "Mie Goreng", location: "Warung Pinggir Jalan", spiciness: 3, img: "food_0"),
//        FoodItem(name: "Ayam Betutu", location: "Resto Bali", spiciness: 5, img: "food_0")
//    ]
    
    @Query(sort: \FoodData.date, order: .reverse) private var foodData: [FoodData]
    @State private var searchText: String = ""
    var onAddFoodFunc: (() -> Void)? = nil
    
    let columns = [
//        GridItem(.adaptive(minimum: 175, maximum: 290))
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
             ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    if (foodData.isEmpty) {
                        VStack (spacing: 20) {
                            Image(.emojiSad)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            Text("It's quiet here. Start record your spicy food!")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 300, alignment: .center)
                            Button(action: {onAddFoodFunc?()}) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.orangeish)
                                    .shadow(color:.orangeish.opacity(0.35), radius: 8, x: 0, y: 12)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 550)
                    } else {
                        Text("February 2025")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                        WaterfallGrid(data: foodData, columns: 2, spacing: 12) { item in
                            NavigationLink(destination: FoodDetailsView(
                                food: item
                            )) {
                                FoodCard(
                                    food: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            //                        .accentColor(.white)
                            //                        .padding(.bottom, 8)
                            
                        }
                        .padding(.bottom)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
             }
//            .padding()
            .navigationTitle(Text("Food Gallery"))
            .searchable(text: $searchText)
        }
    }
}




#Preview {
    FoodGalleryView()
}

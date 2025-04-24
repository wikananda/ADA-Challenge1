//
//  ContentView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 11/04/25.
//

import SwiftUI

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let spiciness: Int
    let image: String
}

struct FoodGalleryView: View {
    let foodItems = [
        FoodItem(name: "Nasi Goreng", location: "Warung Bali", spiciness: 3, image: "food_0"),
        FoodItem(name: "Sate Ayam", location: "Pasar Malam", spiciness: 2, image: "food_0"),
        FoodItem(name: "Rendang", location: "Rumah Padang", spiciness: 4, image: "food_0"),
        FoodItem(name: "Gado-gado", location: "Warung Jawa", spiciness: 1, image: "food_0"),
        FoodItem(name: "Bakso", location: "Gerobak Pak Tono", spiciness: 2, image: "food_0"),
        FoodItem(name: "Soto Ayam", location: "Kedai Soto", spiciness: 2, image: "food_0"),
        FoodItem(name: "Mie Goreng", location: "Warung Pinggir Jalan", spiciness: 3, image: "food_0"),
        FoodItem(name: "Ayam Betutu", location: "Resto Bali", spiciness: 5, image: "food_0"),
        FoodItem(name: "Nasi Goreng", location: "Warung Bali", spiciness: 3, image: "food_0"),
        FoodItem(name: "Sate Ayam", location: "Pasar Malam", spiciness: 2, image: "food_0"),
        FoodItem(name: "Rendang", location: "Rumah Padang", spiciness: 4, image: "food_0"),
        FoodItem(name: "Gado-gado", location: "Warung Jawa", spiciness: 1, image: "food_0"),
        FoodItem(name: "Bakso", location: "Gerobak Pak Tono", spiciness: 2, image: "food_0"),
        FoodItem(name: "Soto Ayam", location: "Kedai Soto", spiciness: 2, image: "food_0"),
        FoodItem(name: "Mie Goreng", location: "Warung Pinggir Jalan", spiciness: 3, image: "food_0"),
        FoodItem(name: "Ayam Betutu", location: "Resto Bali", spiciness: 5, image: "food_0")
    ]
    
//    var foodItems = [FoodCard]()
    @State private var searchText: String = ""
    
    let columns = [
//        GridItem(.adaptive(minimum: 175, maximum: 290))
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
             ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("February 2025")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                    WaterfallGrid(data: foodItems, columns: 2, spacing: 12) { item in
                        NavigationLink(destination: FoodDetailsView(
                            img: item.image,
                            title: item.name,
                            location: item.location
                        )) {
                            FoodCard(
                                img: item.image,
                                name: item.name,
                                location: item.location,
                                spiciness: item.spiciness)
                        }
                        .buttonStyle(PlainButtonStyle())
//                        .padding(.bottom, 8)
                        
                    }
                    .padding(.bottom)
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

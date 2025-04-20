//
//  ContentView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 11/04/25.
//

import SwiftUI

struct FoodGalleryView: View {
    var foodItems = [FoodCard]()
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("February 2025")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                        HStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<10) { i in
                                    let isVertical = i % 3 == 0
                                    FoodCard(vertical: isVertical)
                                }
                            }
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<11) { i in
                                    let isVertical = (i % 3 == 2 && i > 0)
                                    FoodCard(vertical: isVertical)
                                }
                            }
                        }
                        
                        //                    LazyVGrid(columns: columns, spacing: 12) {
                        //                        ForEach(1..<10) { i in
                        //                            let isVertical = i % 3 == 0
                        //
                        //                            FoodCard(vertical: isVertical)
                        //                        }
                        //                    }
                        //                    FoodCard()
                        //                    FoodCard(vertical: true)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding()
                .navigationTitle(Text("Food Gallery"))
                .searchable(text: $searchText)
            }
            .tabItem {
                Text("Food")
                Image(systemName: "house.fill")
            }
        }
    }
}



#Preview {
    FoodGalleryView()
}

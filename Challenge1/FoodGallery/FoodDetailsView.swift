//
//  FoodDetailsView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 14/04/25.
//

import SwiftUI
import SwiftData

struct FoodDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
//    var img: String = "food_0"
//    var title: String = "Food Name"
//    var date: String = "Jun 10, 2024"
//    var time: String = "12:00 PM"
//    var location: String = "Warung Indo"
    
    @Bindable var food: FoodData
    @State var showMenu: Bool = false
    @State var showEditMenu: Bool = false
    
    private var img: UIImage {
        if let uiImage = loadImageFromDocuments(fileName: food.img) {
            return uiImage
        }
        return UIImage(resource: .food0)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 8) {
                    HStack (alignment: .center) {
                        Text(food.name)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {showMenu = true}) {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                        }
                        .confirmationDialog("Options", isPresented: $showMenu) {
                            Button("Edit") {
                                showEditMenu = true
                            }
                            Button("Delete", role: .destructive) {
                                context.delete(food)
                                dismiss()
                            }
                            Button("Cancel", role: .cancel) {
                                // nothing
                            }
                        }
                        .accentColor(.orangeish)
                        .environment(\.colorScheme, .light)
                    }
                    Text(food.date.formatted(.dateTime.day().month().year().hour().minute()))
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                        Text(food.location)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 10)
                    
                    HStack {
                        TastinessCard(tastiness: food.tastiness)
                        Spacer()
                        SpicinessCard(spiciness: food.spiciness)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showEditMenu){
            NavigationView {
                FoodEditView(capturedImage: .constant(nil), food: food)
            }
            .accentColor(.orangeish)
            .environment(\.colorScheme, .light)
        }
    }
}

#Preview {
    FoodDetailsView(food: dummyFood)
}

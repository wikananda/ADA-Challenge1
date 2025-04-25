//
//  FoodDetailsView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 14/04/25.
//

import SwiftUI

struct ChallengeDetailsView: View {
    var food: FoodData
    @State private var userResponse : String? = nil
    @Binding var navigationPath: NavigationPath
//    @State private var showLevelUp = false
//    @State private var isLevelUp = false
//    var img: String = "food_0"
//    var title: String = "Food Name"
//    var date: String = "Jun 10, 2024"
//    var time: String = "12:00 PM"
//    var location: String = "Warung Indo"
    private var img: UIImage {
        if let uiImage = loadImageFromDocuments(fileName: food.img) {
            return uiImage
        }
        return UIImage(resource: .food0)
    }
    
    @State var tastiness: Int
    @State var spiciness: Int
    
    init(food: FoodData, navigationPath: Binding<NavigationPath>) {
        self.food = food
        self._navigationPath = navigationPath
        _tastiness = State(initialValue: food.tastiness)
        _spiciness = State(initialValue: food.spiciness)
    }
    
    var body: some View {
        ScrollView {
            Image(uiImage: img)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(food.name)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
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
                    
                    Spacer(minLength: 20)
                    
                    if (userResponse == nil) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Have you eaten this food again?")
                                .font(.system(size: 16, weight: .bold))
                            HStack(spacing: 20) {
                                Button(action: {userResponse = "no"} ) {
                                    Label("No", systemImage: "xmark")
                                }
                                .padding()
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .background(.red.opacity(0.1))
                                .clipShape(Capsule())
                                
                                Button(action: {userResponse = "yes"}) {
                                    Label("Yes", systemImage: "checkmark")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .background(.orangeish)
                                .clipShape(Capsule())
                            }
                        }
                        
                    } else if (userResponse == "no") {
                        VStack(alignment: .center) {
                            Text("Come back later once you've eaten this food again.")
                                .frame(maxWidth: 275)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                    } else if (userResponse == "yes") {
                        Group {
                            VStack (alignment: .leading, spacing: 15) {
                                Text("Rate tastiness again")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                TastinessMeter(tastiness: $tastiness)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            VStack (alignment: .leading, spacing: 15) {
                                Text("Rate Spiciness again")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                SpicinessMeter(spiciness: $spiciness)
                            }
                        }
                    }
                }
                
                if (userResponse == "yes") {
                    Button(action: {
                        let isLevelUp = spiciness < food.spiciness
//                            showLevelUp = true
                        navigationPath.append(
                            LevelUpNavigation(
                                isLevelUp: isLevelUp
                            )
                        )
                    }) {
                        Label("Submit", systemImage: "text.document")
                    }
                    .buttonStyle(
                        ScaleButtonStyle(scaleAmount: 1.1, defaultColor: .orangeish, highlightColor: .white)
                    )
                }
                
            }
            .padding(.horizontal, 25)
        }
        .ignoresSafeArea(edges: .top)
    }
}

//#Preview {
//    @State var path = NavigationPath()
//    ChallengeDetailsView(food: dummyFood, navigationPath: $path)
//}

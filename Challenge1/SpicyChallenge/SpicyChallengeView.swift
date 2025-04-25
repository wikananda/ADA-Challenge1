//
//  ProgressView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 17/04/25.
//

import SwiftUI
import SwiftData


struct SpicyChallengeView: View {
    @Environment(\.modelContext) private var context
    @Query var foods: [FoodData]
    @Query private var users: [UserData]
        
//    @State private var progress: Double = 0.0
//    @State private var spicyLevel: Int = 2
//    @State private var spicyCount: Int = 0
    private let goal: Int = 10
    
    @State private var showLevelUp = false
    private var isLevelUp = false
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            let user = users.first
            let spicyLevel = user?.level ?? 2
            let spicyCount = user?.spicyCount ?? 0
            let progress: Double = Double(spicyCount) / Double(10)
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
                            Text("Eat ") + Text("\(goal - spicyCount)").fontWeight(.heavy) + Text(" spicy food") + Text(" level \(spicyLevel) or more").fontWeight(.heavy) + Text(" to level up!")
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
                .onAppear {
                    print("spicy count: \(spicyCount) progress: \(progress)")
                }
                
                let foodCount = foods.count
                if (foodCount < 10) {
                    VStack (alignment: .center, spacing: 20) {
                        Image(.emojiSmile)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Group {
                            Text("Your next challenge will appear after you eat") + Text(" \(10 - foodCount) more spicy food!").fontWeight(.heavy)
                        }
                        .frame(maxWidth: 300)
                        .multilineTextAlignment(.center)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                } else {
                    let challenge: FoodData = GetFoodChallenge(foods: foods, level: spicyLevel)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        Text("Your Next Challenge")
                            .font(.system(size: 16, weight: .bold))
                        Button {
                            navigationPath.append(challenge)
                        } label: {
                            ChallengeCard(food: challenge)
                        }
                        .buttonStyle(PlainButtonStyle())

                    }
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationDestination(for: FoodData.self) { food in
                ChallengeDetailsView(food: food, navigationPath: $navigationPath)
            }
            .navigationDestination(for: LevelUpNavigation.self) { nav in
                LevelUpView(
                    isLevelUp: nav.isLevelUp,
                    onOk: {
                        navigationPath.removeLast(navigationPath.count)
                    })
            }
        }
    }
}

struct LevelUpNavigation: Hashable {
    let isLevelUp: Bool
}

// Filtering food data
func GetFoodChallenge(foods: [FoodData], level: Int) -> FoodData {
    // Get all available spicy food above {level} and get minimum available level
    let availableSpicy = foods
        .map { $0.spiciness }
        .filter { $0 >= level }
    let minAvailableLevel = availableSpicy.min()
    
    // Get availabel spicy food at minimum level
    let filteredFoods = foods.filter { $0.spiciness == minAvailableLevel }
    
    // Sort by tastiness from lower to higher
    let foodChallenge = filteredFoods.sorted{ $0.tastiness > $1.tastiness }
    return foodChallenge[0]
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

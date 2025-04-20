//
//  SpicinessMeter.swift
//  Challenge1
//
//  Created by Komang Wikananda on 15/04/25.
//

import SwiftUI

struct SpicinessMeter: View {
    @State private var spiciness: Int = 10
    @State var isEditing = false
    
//    let images: [ImageResource] = [.emojiDead, .emojiSad, .emojiNeutral, .emojiSmile, .emojiLaugh]
    let colors: [Color] = [.spicy0, .spicy0, .spicy2, .spicy3, .spicy4, .spicy5, .spicy6, .spicy7, .spicy8, .spicy9, .spicy10]
    let fontWeights: [Font.Weight] = [.regular, .regular, .regular, .medium, .medium, .bold, .bold, .heavy, .black, .black, .black]
    let fontSizes: [CGFloat] = [32, 32, 32, 32, 32, 32, 38, 48, 64, 82, 82]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    if (spiciness < 10) {
                        Text("Level \(spiciness)")
                            .frame(maxHeight: .infinity, alignment: .top)
                            .font(.system(size: fontSizes[spiciness],
                                          weight: fontWeights[spiciness]))
                            .foregroundColor(.white)
                    } else {
                        Image(.emojiDeadFill)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [colors[spiciness].opacity(1), colors[spiciness].opacity(0.7), colors[spiciness].opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(maxHeight: 100, alignment: .bottom)
                }
                Slider(
                    value: Binding(
                        get: { Double(self.spiciness) },
                        set: { self.spiciness = Int($0) }
                    ),
                    in: 0...10,
                    step: 1
                ) {
                    Text("")
                } minimumValueLabel: {
                    Image(.flameFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                } maximumValueLabel: {
                    Image(.flameFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                        .foregroundColor(.white)
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .padding(.horizontal)
                .accentColor(.white)
            }
            .padding()
        }
        .frame(height: 190, alignment: .topLeading)
        .background(colors[spiciness])
        .cornerRadius(20)
        .shadow(color: colors[spiciness].opacity(0.3), radius: 12, x: 0, y: 12)
    }
}

#Preview {
    SpicinessMeter()
}

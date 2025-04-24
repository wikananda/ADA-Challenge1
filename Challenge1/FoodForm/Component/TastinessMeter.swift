//
//  TastinessMeter.swift
//  Challenge1
//
//  Created by Komang Wikananda on 15/04/25.
//

import SwiftUI


struct TastinessMeter: View {
    @Binding var tastiness: Int
    @State var isEditing = false
    
    let images: [ImageResource] = [.emojiDead, .emojiSad, .emojiNeutral, .emojiSmile, .emojiLaugh]
    let colors: [Color] = [.tasty0, .tasty1, .tasty2, .tasty3, .tasty4]
    let tastinessLevels: [String] = ["URGH...!", "uh...", "okay...", "Tasty!", "AWESOMEE!"]
    let fontWeight: [Font.Weight] = [.black, .regular, .medium, .bold, .heavy]
    let fontSizes: [CGFloat] = [38, 42, 42, 54, 42]
    
    func variativeFontSize(textLength: Int) -> CGFloat {
        let moduloCalc: Int = 3
        let multiplier: Int = 9
        
        let calculatedModule = (textLength % moduloCalc)
        let calculatedSize: CGFloat = CGFloat((calculatedModule * multiplier))
        print(calculatedSize)
        return calculatedSize
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Image(images[tastiness])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                    if (tastiness < 4) {
                        Text(tastinessLevels[tastiness])
                            .font(.system(size: 52 - variativeFontSize(textLength: tastinessLevels[tastiness].count), weight: fontWeight[tastiness]))
//                            .font(.system(size: fontSizes[tastiness], weight: fontWeight[tastiness]))
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .padding(.leading)
                            .padding(.trailing, 20)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else {
                        Text(tastinessLevels[tastiness])
                            .font(.system(size: 48, weight: fontWeight[tastiness]))
                            .foregroundColor(.white)
//                            .padding(.top)
                            .padding(.trailing, 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Slider(
                    value: Binding(
                        get: { Double(self.tastiness) },
                        set: { self.tastiness = Int($0) }
                    ),
                    in: 0...4,
                    step: 1
                ) {
                    Text("")
                } minimumValueLabel: {
                    Text("\(Image(.emojiDeadFill))")
                        .foregroundColor(.white)
                } maximumValueLabel: {
                    Text("\(Image(.emojiLaughFill))")
                        .foregroundColor(.white)
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .padding(.horizontal)
                .accentColor(.white)
            }
        }
        .frame(height: 190, alignment: .topLeading)
        .background(colors[tastiness])
        .cornerRadius(20)
        .shadow(color: colors[tastiness].opacity(0.3), radius: 12, x: 0, y: 12)
    }
}

#Preview {
    TastinessMeter(tastiness: .constant(2))
}

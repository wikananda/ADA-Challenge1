//
//  ProgressView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 17/04/25.
//

import SwiftUI

struct SpicyChallengeView: View {
    @State private var progress = 0.5
    var body: some View {
        VStack {
            Image(.flameFill)
            Text("Level 2")
                .font(.system(size: 34, weight: .bold))
            
            ProgressView(value: progress)
        }
    }
}

#Preview {
    SpicyChallengeView()
}

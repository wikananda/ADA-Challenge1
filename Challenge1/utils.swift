//
//  GlobalFunctions.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 25/04/25.
//
import SwiftUI
import Foundation

// MARK: PUBLIC VARIABLES
var randomSeed: Int = 256

// MARK: BUTTON EFFECTS
struct ScaleButtonStyle: ButtonStyle {

    var scaleAmount: CGFloat
    var defaultColor: Color
    var highlightColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        ScaleButton(
            configuration: configuration,
            scaleAmount: scaleAmount,
            defaultColor: defaultColor,
            highlightColor: highlightColor
        )
    }
}

private extension ScaleButtonStyle {
    struct ScaleButton: View {

        @Environment(\.isEnabled) var isEnabled

        let configuration: ScaleButtonStyle.Configuration
        let scaleAmount: CGFloat
        let defaultColor: Color
        let highlightColor: Color

        var body: some View {
            return configuration.label
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(configuration.isPressed ? highlightColor : defaultColor)
                .foregroundColor(configuration.isPressed ? defaultColor : highlightColor)
                .clipShape(Capsule())
                .shadow(color: .orangeish.opacity(0.25), radius: 12, x: 0, y: 10)
                .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
                .padding(.top, 20)
        }
    }
}

// MARK: SAVE AND LOAD IMAGE

func loadImageFromDocuments(fileName: String) -> UIImage? {
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent(fileName)
    return UIImage(contentsOfFile: url.path)
}

func saveImageToDocuments(_ image: UIImage, filename: String) -> String? {
    if let data = image.pngData() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return url.path
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    return nil
}

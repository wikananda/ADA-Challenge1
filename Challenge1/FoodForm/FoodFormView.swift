//
//  FoodFormView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 15/04/25.
//

import SwiftUI

struct FoodFormView: View {
    @State var img: String = "food_0"
    @Binding var capturedImage: UIImage?
    @State var isShowingImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var foodName: String = ""
    @State var location: String = ""
    @State var date: Date = Date()

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                if let capturedImage = capturedImage {
                    Image(uiImage: capturedImage)
                        .resizable()
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.12), radius: 15, x: 0, y: 12)
                        .scaledToFit()
                } else {
                    Image(img)
                        .resizable()
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.12), radius: 15, x: 0, y: 12)
                        .scaledToFit()
                }

                // Camera button
                Button(action: {
                    sourceType = .camera
                    isShowingImagePicker = true
                }) {
                    Label("Retake Photo", systemImage: "camera")
                        .padding()
                        .padding(.horizontal)
                        .background(Color.orangeish.opacity(0.8))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                //                    .frame(height: .infinity)
                //                    .padding(.horizontal)

                // Food name writer
                VStack (alignment: .leading) {
                    VStack (alignment: .leading) {
                        HStack(alignment: .center, spacing: 20) {
                            Text("Food name")
                                .frame(width: 100, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black)
                            
                            TextField("e.g. Fried Rice", text: $foodName)
                                .textFieldStyle(.plain)
                        }
                        .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.2))
                    }

                    // Date picker
                    VStack (alignment: .leading) {
                        HStack(alignment: .center, spacing: 20) {
                            Text("Date")
                                .frame(width: 100, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black)
                            
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .accentColor(.orangeish)
                        }
                        .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.2))
                    }

                    // Location picker
                    VStack (alignment: .leading) {
                        HStack(alignment: .center, spacing: 20) {
                            Text("Location")
                                .frame(width: 100, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black)
                            
                            TextField("e.g. Warung Indo", text: $location)
                                .textFieldStyle(.plain)
                        }
                        .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.2))
                    }
                }
                VStack (alignment: .leading, spacing: 15) {
                    Text("Tastiness")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    TastinessMeter()
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading, spacing: 15) {
                    Text("Spiciness")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    SpicinessMeter()
                }
                
                Button(action: SubmitForm) {
                    Label("Save", systemImage: "checkmark.circle")
                }
                .buttonStyle(
                    ScaleButtonStyle(scaleAmount: 1.1, defaultColor: .orangeish, highlightColor: .white)
                )
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text("Add Food"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(sourceType: sourceType,
                selectedImage: Binding(
                    get: { capturedImage ?? UIImage() },
                    set: { capturedImage = $0 }
                ))
        }
    }
    
    func SubmitForm() {
        dismiss()
    }
}


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

#Preview {
//    FoodFormView()
}

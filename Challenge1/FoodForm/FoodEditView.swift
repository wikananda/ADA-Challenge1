//
//  FoodFormView.swift
//  Challenge1
//
//  Created by Komang Wikananda on 15/04/25.
//

import SwiftUI
import SwiftData

struct FoodEditView: View {
    @Binding var capturedImage: UIImage?
    @State var isShowingImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    // @State var foodName: String = ""
    // @State var location: String = ""
    // @State var date: Date = Date()
    
    @Bindable var food: FoodData

    @State private var newName: String
    @State private var newLocation: String
    @State private var newDate: Date
    @State private var newTastiness: Int
    @State private var newSpiciness: Int

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private var img: UIImage {
        if let uiImage = loadImageFromDocuments(fileName: food.img) {
            return uiImage
        }
        return UIImage(resource: .food0)
    }
    
    init (capturedImage: Binding<UIImage?>, food: FoodData)
    {
        self._capturedImage = capturedImage
        self._food = Bindable(wrappedValue: food)
        _newName = State(initialValue: food.name)
        _newLocation = State(initialValue: food.location)
        _newDate = State(initialValue: food.date)
        _newTastiness = State(initialValue: food.tastiness)
        _newSpiciness = State(initialValue: food.spiciness)
    }
    
    
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
                    Image(uiImage: img)
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
                            
                            TextField(newName, text: $newName)
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
                                selection: $newDate,
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
                            
                            TextField(newLocation, text: $newLocation)
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
                    TastinessMeter(tastiness: $newTastiness)
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading, spacing: 15) {
                    Text("Spiciness")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    SpicinessMeter(spiciness: $newSpiciness)
                }
            
                Button(action: UpdateFood) {
                    Label("Save", systemImage: "checkmark.circle")
                }
                .buttonStyle(
                    ScaleButtonStyle(scaleAmount: 1.1, defaultColor: .orangeish, highlightColor: .white)
                )
                Button(action: { dismiss() }) {
                    Label("Cancel", systemImage: "xmark")
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.red.opacity(0.2))
                .foregroundColor(.red)
                .clipShape(Capsule())
                .shadow(color: .orangeish.opacity(0.25), radius: 12, x: 0, y: 10)            }
            .padding(.horizontal)
        }
        .navigationTitle(Text("Edit Food"))
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

    func UpdateFood() {
        if let imgToSave = capturedImage {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH.mm.ss"
            let dateString = dateFormatter.string(from: newDate)
            let fileName = "\(newName)_\(newLocation)_\(dateString).png"
            
//            UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
            if let savedFilePath = saveImageToDocuments(imgToSave, filename: fileName) {
                print("Image saved to \(savedFilePath)")
                food.img = fileName
            }
        }
        
        food.name = newName
        food.date = newDate
        food.location = newLocation
        food.tastiness = newTastiness
        food.spiciness = newSpiciness
        dismiss()
    }
}

#Preview {
    FoodEditView(capturedImage: .constant(nil), food: dummyFood)
}

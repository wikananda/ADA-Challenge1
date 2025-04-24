//
//  SpicerView.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 21/04/25.
//

import SwiftUI

struct SpicerView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var activeTab: Int = 0
    @State private var showFoodForm = false

    var body: some View {
        TabView(selection: $activeTab) {
            FoodGalleryView()
                .tabItem {
                    Label("Food Gallery", systemImage: "carrot")
                }
                .tag(0)
            
            Color.clear
                .tabItem {
                    Label("", systemImage: "plus.circle")
                }
                .tag(1)
            
            SpicyChallengeView()
                .tabItem {
                    Label("Challenge", systemImage: "flame")
                }
                .tag(2)
        }
        .background(.white)
        .accentColor(.orangeish)
        .onChange(of: activeTab) { newValue in
            if newValue == 1 {
                showImagePicker = true
                activeTab = 0
            }
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: {
            if selectedImage != nil {
                showFoodForm = true
            }
        }) {
            ImagePickerWrapper(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showFoodForm, onDismiss: {
            selectedImage = nil
        }) {
            NavigationView {
                FoodFormView(capturedImage: $selectedImage)
            }
            .accentColor(.orangeish)
        }
    }
}

struct ImagePickerWrapper: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempImage: UIImage = UIImage()

    var body: some View {
        ImagePicker(sourceType: .camera, selectedImage: $tempImage)
            .onChange(of: tempImage) { newImage in
                if let data = newImage.pngData(), !data.isEmpty {
                    selectedImage = newImage
                    dismiss()
                }
            }
    }
}

#Preview {
    SpicerView()
}

//
//  SpicerView.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 21/04/25.
//

import SwiftUI
import SwiftData

struct SpicerView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var activeTab: Int = 0
    @State private var showFoodForm = false
    
    @Environment(\.modelContext) private var context
    @Query var users: [UserData]
    
    func OpenCamera() {
        showImagePicker = true
        activeTab = 0
    }

    var body: some View {
        TabView(selection: $activeTab) {
            FoodGalleryView(onAddFoodFunc: OpenCamera)
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
                    .environment(\.modelContext, context)
            }
            .accentColor(.orangeish)
            .environment(\.colorScheme, .light)
        }
        .onAppear {
            if users.isEmpty {
                let user = UserData()
                context.insert(user)
            }
            print("users count: \(users.count)")
//            let user = users.first
//            user?.resetLevelTo(level: 4)
//            try? context.save()
            
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

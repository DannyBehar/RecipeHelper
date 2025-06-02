//
//  ImageWithPlaceholder.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

import SwiftUI

struct ImageWithPlaceholder: View {
    let uiImage: UIImage?
    
    var isShowingPlaceholder: Bool {
        uiImage == nil
    }
    
    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundStyle(.tertiary)
            }
        }
        .id(isShowingPlaceholder)
        .transition(.opacity.animation(.linear(duration: 0.12)))
    }
}

struct ImageWithPlaceholderPreviewContainer: View {
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: Spacing.medium) {
            ImageWithPlaceholder(uiImage: uiImage)
                .scaledToFit()
                .frame(width: 72, height: 72)
            
            Button("Toggle Image") {
                loadImage()
            }
        }
    }
    
    func loadImage() {
        if uiImage != nil {
            uiImage = nil
        } else {
            uiImage = UIImage(named: "strawberry-rhubarb-pie-large")
        }
    }
}

#Preview {
    ImageWithPlaceholderPreviewContainer()
}

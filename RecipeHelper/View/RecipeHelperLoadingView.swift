//
//  RecipeHelperLoadingView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 6/1/25.
//

import SwiftUI

struct RecipeHelperLoadingView: View {
    @State private var isShowing = false
    @State var shimmerEeffect = false
    @ScaledMetric var imageSize = Constants.listItemImageSize
    
    var body: some View {
        Group {
            if isShowing {
                contentView
            } else {
                Color(.systemBackground)
            }
        }
        .task {
            // need to wait for SwiftUI to establish the view port width before starting the animation
            await Task.sleep(seconds: 0.01)
            isShowing.toggle()
        }
    }
    
    var contentView: some View {
        ScrollView {
            VStack(spacing: Spacing.medium) {
                ForEach(0..<20, id: \.self) { index in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color(.systemGray5), Color(.systemGray6)],
                                                 startPoint: .leading,
                                                 endPoint: shimmerEeffect ? .trailing : .leading))
                            .frame(width: imageSize, height: imageSize)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color(.systemGray5), Color(.systemGray6)],
                                                 startPoint: .leading,
                                                 endPoint: shimmerEeffect ? .trailing : .leading))
                            
                    }
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: false), value: shimmerEeffect)
                    
                }
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            shimmerEeffect.toggle()
        }
        .padding(Spacing.medium)
        .padding(.trailing, Spacing.medium)
    }
}

#Preview {
    RecipeHelperLoadingView()
}

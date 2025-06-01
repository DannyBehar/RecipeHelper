//
//  RecipeHelperLoadingView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 6/1/25.
//

import SwiftUI

struct RecipeHelperLoadingView: View {
    @State var shimmerEeffect = false
    @ScaledMetric var imageSize = Constants.listItemImageSize
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.medium) {
                ForEach(0..<20, id: \.self) { index in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color(.systemGray4), Color(.systemGray5)],
                                                 startPoint: .leading,
                                                 endPoint: shimmerEeffect ? .trailing : .leading))
                            .frame(width: imageSize, height: imageSize)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color(.systemGray4), Color(.systemGray5)],
                                                 startPoint: .leading,
                                                 endPoint: shimmerEeffect ? .trailing : .leading))
                            .frame(maxWidth: .infinity)
                    }
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: false), value: shimmerEeffect)
                }
            }
        }
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

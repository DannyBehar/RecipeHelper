//
//  RecipeDetailView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/28/25.
//

import SwiftUI

struct RecipeDetailView: View {
    var uiImage: UIImage?
    
    let recipe: Recipe
    
    var image: Image {
        if let uiImage {
            return Image(uiImage: uiImage)
        } else {
            return Image(uiImage: UIImage())
        }
    }
    
    var shouldShowBottomPanel: Bool {
        recipe.youtubeUrl != nil ||
        recipe.sourceUrl != nil
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ImageWithPlaceholder(uiImage: uiImage)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(Spacing.large)
                    .shadow(radius: 12)
            }
            
            if shouldShowBottomPanel {
                HStack(spacing: 12) {
                    if let url = URL(string: recipe.sourceUrl ?? "") {
                        Link(destination: url) {
                            youtubeButtonContent
                                .opacity(0.0)
                                .overlay {
                                    webButtonContent
                                }
                                .padding()
                                .background(Color.black)
                                .clipShape(.capsule)
                        }
                    }
                    
                    if let url = URL(string: recipe.youtubeUrl ?? "") {
                        Link(destination: url) {
                            youtubeButtonContent
                                .padding()
                                .background(Color.black)
                                .clipShape(.capsule)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .ignoresSafeArea(.all)
            }
        }
        .navigationTitle(recipe.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    ShareRecipeView(recipe: recipe, thumbnail: image)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                
            }
        }
        .toolbarBackground(.thinMaterial, for: .navigationBar)
        .background {
            image.resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 18)
                .padding(.top, Spacing.mediumLarge)
        }
    }
    
    var webButtonContent: some View {
        HStack {
            Image(systemName: "richtext.page")
                .symbolRenderingMode(.palette)
                .symbolVariant(.fill)
                .foregroundStyle(.white, .red)
                .imageScale(.large)
            
            Text("Web")
                .foregroundStyle(.white)
                .bold()
        }
    }
    
    var youtubeButtonContent: some View {
        HStack {
            Image(systemName: "play.rectangle")
                .symbolRenderingMode(.palette)
                .symbolVariant(.fill)
                .foregroundStyle(.white, .red)
                .imageScale(.large)
            
            Text("Youtube")
                .foregroundStyle(.white)
                .bold()
        }
    }
}

#Preview("With Link Pane") {
    NavigationStack {
        RecipeDetailView(uiImage: UIImage(named: "strawberry-rhubarb-pie-large"), recipe: .apamBalik)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Without Link Pane") {
    NavigationStack {
        RecipeDetailView(uiImage: UIImage(named: "strawberry-rhubarb-pie-large"), recipe: .strawberryRhubarbPie)
            .navigationBarTitleDisplayMode(.inline)
    }
}

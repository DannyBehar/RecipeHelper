//
//  AboutView.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 6/1/25.
//

import SwiftUI

struct AboutUsView: View {
    let blueskyUrl = URL(string: "https://bsky.app/profile/dannybehar.social")!
    
    var body: some View {
        VStack(spacing: Spacing.mediumLarge) {
            Image("DannyAndCharlie")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.white, lineWidth: 2.0)
                }
                .shadow(radius: Spacing.extraSmall)
            
            GroupBox {
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Thank you for checking out **Reciplease! \(Image(systemName: "fork.knife"))** \n")
                            
                            Text("Danny is an iOS developer and musician living in Baltimore, MD 🦀. When he isn't coding and making music apps, he enjoys taking walks with his pup Charlie and sometimes goes swing dancing around the city. You can find his Bluesky link below! \n")
                            
                            Text("Charlie is a Jack Russell, Beagle mix. He mostly naps during the day but loves to play at the dog park and eat all the treats! \n")
                            
                            Text("Hope you enjoy the app as much as we enjoyed making it!")
                        }
                        .font(.system(.body, design: .rounded))
                    }
                    
                    Divider()
                    Text("- Danny 👨🏻‍💻 & Charlie 🐶")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, Spacing.extraSmall)
                }
            }
            
            Link(destination: URL(string: "https://bsky.app/profile/dannybehar.social")!) {
                Text("Bluesky")
                    .foregroundStyle(Color.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        }
        .padding(Spacing.medium)
        .background(Color(.systemBackground))
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AboutUsView()
    }
}

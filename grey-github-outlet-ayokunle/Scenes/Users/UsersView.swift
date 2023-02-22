//
//  UsersView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct UsersView: View {
    
    static let emptyText = "Search Github for users..."
    @Binding var repoInfo: String
    
    var body: some View {
        NavigationView {
            ZStack {
                
                HStack(spacing: 0) {
                    
                    searchBar
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    Spacer()
                    
                    Button("Search") {
                        handleSearchButtonClicked()
                    }
                    .frame(width: 85, height: 35)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(4)
                    .modifier(ManropeFont(fName: .extrabold, size: 12))
                    
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                .clipped()
                .padding()
                
                VStack(spacing: 20) {
                    Image("search-large")
                    Text(UsersView.emptyText)
                        .multilineTextAlignment(.center)
                        .modifier(ManropeFont(fName: .medium, size: 12))

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Users")
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
        }
        .accentColor(Color(.label)) // Navigation back color
    }
    
    var searchBar: some View {
        HStack {
            Image("search-small")
            TextField("Search for users...", text: $repoInfo)
                .modifier(ManropeFont(fName: .regular, size: 10))
        }
        .padding(10)
        .border(.gray)
        .frame(height: 35)
        .cornerRadius(3)
        .background(Color.white)
    }
    
    func handleSearchButtonClicked() {
        
    }
}

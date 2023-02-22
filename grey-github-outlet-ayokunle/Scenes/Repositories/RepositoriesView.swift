//
//  RepositoriesView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct RepositoriesView: View {
    
    static let emptyText = "Search Github for repositories, issues and pull requests!"
    @Binding var repoInfo: String
    
    var body: some View {
        NavigationView {
            ZStack {
                HStack(spacing: 0) {
                    searchBar
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    Spacer() // Space
                    
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
                    Text(RepositoriesView.emptyText)
                        .multilineTextAlignment(.center)
                        .modifier(ManropeFont(fName: .medium, size: 12))

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Repositories")
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            Image("search-small")
            TextField("Search for repositories...", text: $repoInfo)
                .modifier(ManropeFont(fName: .regular, size: 10))
        }
        .padding(10)
        .background(Color.white)
        .border(.gray)
        .frame(height: 35)
        .cornerRadius(3)
    }
    
    func handleSearchButtonClicked() {
        
    }
}

//
//  HomeVC.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct HomeVC: View {
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @Binding var selectedTab: String
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    LazyHGrid(rows: gridLayout, alignment: .top, spacing: 10) {
                        UserCell(selectedTab: $selectedTab)
                        RepoCell(selectedTab: $selectedTab)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
            }
//            VStack {
//                HStack(spacing: 15) {
//                    UserCell(selectedTab: $selectedTab)
//                    RepoCell(selectedTab: $selectedTab)
//                }
//                .frame(maxWidth: .infinity, alignment: .topLeading)
//                .padding()
//                Spacer()
//            }
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Home")
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
        }
    }
}

struct UserCell: View {
    
    static let tag = "users"
    @Binding var selectedTab: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("cyan")
            VStack(alignment: .leading, spacing: 30) {
                Image("user")
                    .frame(width: 20, height: 20)
                Text("Users").fontWeight(.bold)
                    .modifier(ManropeFont(fName: .regular, size: 16))
            }
            .padding()
        }
        .frame(width: 156, height: 118)
        .onTapGesture {
            selectedTab = UserCell.tag
        }
    }
    
}

struct RepoCell: View {
    
    static let tag = "repo"
    @Binding var selectedTab: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("tintRed")
            VStack(alignment: .leading, spacing: 30) {
                Image("save")
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20)
                    .cornerRadius(2)
                Text("Repositories").fontWeight(.bold)
                    .modifier(ManropeFont(fName: .regular, size: 16))
            }
            .padding()
        }
        .frame(width: 156, height: 118)
        .onTapGesture {
            selectedTab = RepoCell.tag
        }
        
    }
}

//
//  HomeView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

// MARK: Home View
struct HomeView: View {
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @Binding var selectedTab: SelectedTab
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
//            ZStack(alignment: .top) {
//                VStack {
//                    LazyHGrid(rows: gridLayout, alignment: .top, spacing: 10) {
//                        UserCell(selectedTab: $selectedTab)
//                        RepoCell(selectedTab: $selectedTab)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .topLeading)
//                    .padding()
//                }
//            }
            VStack {
                HStack(spacing: 15) {
                    UserCell(selectedTab: $selectedTab)
                    RepoCell(selectedTab: $selectedTab)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                Spacer()
            }
            .offset(y: -55)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text(viewModel.constantViewModel.home)
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
        }
    }
}

// MARK: User Clickable View
struct UserCell: View {
    
    @Binding var selectedTab: SelectedTab
    var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("cyan")
            VStack(alignment: .leading, spacing: 25) {
                Image("user")
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .cornerRadius(4)
                Text(viewModel.constantViewModel.users).fontWeight(.bold)
                    .modifier(ManropeFont(fName: .regular, size: 16))
            }
            .padding()
        }
        .frame(width: 156, height: 118)
        .onTapGesture {
            selectedTab = .users
        }
    }
    
}

// MARK: Repositories Clickable View
struct RepoCell: View {
    
    @Binding var selectedTab: SelectedTab
    var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("tintRed")
            VStack(alignment: .leading, spacing: 25) {
                Image("save")
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .cornerRadius(4)
                Text(viewModel.constantViewModel.repositories).fontWeight(.bold)
                    .modifier(ManropeFont(fName: .regular, size: 16))
            }
            .padding()
        }
        .frame(width: 156, height: 118)
        .onTapGesture {
            selectedTab = .repo
        }
        
    }
}

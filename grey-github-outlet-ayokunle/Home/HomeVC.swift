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
    //@State private var gridColumn: Int = 2
    
    @Binding var selectedTab: String
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                //Color.blue
                //Color.red.ignoresSafeArea(edges: .top)
                VStack {
                    LazyHGrid(rows: gridLayout, alignment: .top, spacing: 10) {
//                        NavigationLink(destination: UsersVC()) {
//                            UserCell()
//                            NotificationCenter.default.post(name: Notification.Name("Tab.switch"), object: nil, userInfo: ["location": 2])
//                        }
                        UserCell(selectedTab: $selectedTab)
                        RepoCell(selectedTab: $selectedTab)
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                }
                //.border(.red)
            }
            //.navigationTitle("Home").font(.footnote)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Home").font(.title).fontWeight(.bold)
                    }
                }
            }
            //.statusBarHidden()
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
            }
            .padding()
        }
        .frame(width: 156, height: 118)
        .onTapGesture {
            selectedTab = RepoCell.tag
        }
        
    }
}

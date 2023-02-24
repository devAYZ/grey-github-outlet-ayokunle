//
//  UsersView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct UsersView: View {
    
    @Binding var userSearchInput: String
    @State var hideTableView = true
    static let beginSearchUserText = "Search Github for users..."
    static let emptySearchUserText = "We’ve searched the ends of the earth and we’ve not found this user, please try again"
    @State var searchUserText = beginSearchUserText
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    
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
                           alignment: .topLeading)
                    .clipped()
                    .padding()
                    
                    ZStack {
                        VStack(spacing: 20) {
                            Image("search-large")
                            Text(searchUserText)
                                .multilineTextAlignment(.center)
                                .modifier(ManropeFont(fName: .medium, size: 12))

                        }
                        
                        tableView
                            .opacity(hideTableView ? 0 : 1)
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity)
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
            if #available(iOS 15.0, *) {
                TextField("Search for users...", text: $userSearchInput)
                    .modifier(ManropeFont(fName: .regular, size: 12))
                    .onSubmit {
                        handleSearchButtonClicked()
                    }
            } else {
                // Fallback on earlier versions
                TextField("Search for users...", text: $userSearchInput)
                    .modifier(ManropeFont(fName: .regular, size: 12))
            }
        }
        .padding(10)
        .border(.gray)
        .frame(height: 38)
        .cornerRadius(3)
        .background(Color.white)
    }
    
    var tableView: some View {
        List {
            ForEach(1..<21) { i in
                Text("Demo-User \(i)")
            }
            .modifier(ManropeFont(fName: .medium, size: 13))
        }
    }
    
    func handleSearchButtonClicked() {
        showLoader()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            hideLoader()
            if userSearchInput.count > 0 {
                self.hideTableView = false
                self.hideKeyboard()
                searchUserText = UsersView.beginSearchUserText
            } else {
                self.hideTableView = true
                searchUserText = UsersView.emptySearchUserText
            }
        }
    }
}

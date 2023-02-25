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
    
    @ObservedObject var usersVM = UsersViewModel()
    @State private var showSearchInputAlert = false
    
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
        .alert(isPresented: $showSearchInputAlert) {
            Alert(title: Text(""), message: Text("Search field cannot be empty"))
        }

    }
    
    var searchBar: some View {
        HStack {
            Image("search-small")
            if #available(iOS 15.0, *) {
                TextField("Search for users...", text: $userSearchInput)
                    .modifier(ManropeFont(fName: .regular, size: 12))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
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
            ForEach(usersVM.usersList) { user in
                Text(user.login ?? "")
            }
            .modifier(ManropeFont(fName: .medium, size: 13))
        }
    }
    
    func handleSearchButtonClicked() {
        guard !userSearchInput.isEmpty else {
            showSearchInputAlert = true
            return
        }
        
        hideKeyboard()
        showLoader()
        
        usersVM.searchUsers(searchText: userSearchInput) { response in
            hideLoader()
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    guard let usersItems = data.items, !usersItems.isEmpty else {
                        //
                        hideTableView = true
                        searchUserText = UsersView.emptySearchUserText
                        return
                    }
                    usersVM.usersList = usersItems
                    hideTableView = false
                case .failure(let error):
                    print(error.errorDescription ?? "")
                }
            }
        }
    }
}

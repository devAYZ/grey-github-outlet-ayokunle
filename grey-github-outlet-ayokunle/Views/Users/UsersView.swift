//
//  UsersView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct UsersView: View {
    
    @Binding var userSearchInput: String
    @State var hideTableView = false
    static let beginSearchUserText = "Search Github for users..."
    static let emptySearchUserText = "We’ve searched the ends of the earth and we’ve not found this user, please try again"
    @State var searchUserText = beginSearchUserText
    
    @ObservedObject var usersVM = UsersViewModel()
    @State private var showSearchInputAlert = false
    @State private var searchInputAlertText = ""
    
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
                        
                        listView
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
            Alert(title: Text(""), message: Text(searchInputAlertText))
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
    
    var listView: some View {
//        List {
//            ForEach(usersVM.usersList) { user in
//                //Text(user.login ?? "")
//                UsersListCell(userInfo: user)
//            }
//        }
        List(usersVM.usersList, id: \.id) { user in
            NavigationLink(destination: UserDetailView(userDetail: user)) {
                UsersListCell(userInfo: user)
            }
        }
    }
    
    func handleSearchButtonClicked() {
        guard !userSearchInput.isEmpty else {
            handleShowAlert(message: "Search field cannot be empty")
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
                    handleShowAlert(message: error.errorDescription ?? "")
                }
            }
        }
    }
    
    func handleShowAlert(message: String) {
        searchInputAlertText = message
        showSearchInputAlert = true
    }
}

// MARK: Users List Cell
struct UsersListCell: View {
    
    var userInfo: Item
    
    var body: some View {
        //
        HStack(alignment: .top) {
//            Image("userImage") // Image
//                .resizable()
//                .scaledToFit()
//                .frame(height: 20)
//                .cornerRadius(10)
            AnimatedImage(url: URL(string: userInfo.avatarURL ?? "")) // URL image
                //.placeholder(UIImage(named: "userImage"))
                .placeholder {
                    Circle().foregroundColor(.gray)
                }
                .transition(.fade)
                .resizable() // Its keep the aspect ratio
                .scaledToFit()
                .frame(height: 26)
                .cornerRadius(13)
            //
            VStack(alignment: .leading, spacing: 5) {
                VStack(alignment: .leading) {
                    Text(userInfo.login?.capitalized ?? "") // Name
                        .foregroundColor(Color("dullGreen"))
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .semibold, size: 12))
                    Text(userInfo.login ?? "") // login
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 10))
                }
                Text(userInfo.description ?? "No description") // Desc
                    .lineLimit(2)
                    .modifier(ManropeFont(fName: .regular, size: 10))
               //
                HStack {
                    Text("Lacation..")  // Locattion
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 8))
                    Text("email@email..") // Email
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 8))
                }
                .foregroundColor(.secondary)
            }
            
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(userSearchInput: UsersViewModel.shared.$testString)
    }
}

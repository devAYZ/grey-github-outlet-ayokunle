//
//  RepositoriesView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct RepositoriesView: View {
    
    @Binding var repoSearchInput: String
    @State var hideTableView = true
    static let beginSearchRepoText = "Search Github for repositories, issues and pull requests!"
    static let emptySearchRepoText = "We’ve searched the ends of the earth, repository not found, please try again"
    @State var searchRepoText = beginSearchRepoText
    
    @ObservedObject var repositoriesVM = RepositoriesViewModel()
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
                           alignment: .topLeading)
                    .clipped()
                    .padding()
                    
                    ZStack {
                        VStack(spacing: 20) {
                            Image("search-large")
                            Text(searchRepoText)
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
                        Text("Repositories")
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
            .alert(isPresented: $showSearchInputAlert) {
                Alert(title: Text(""), message: Text(searchInputAlertText))
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            Image("search-small")
            if #available(iOS 15.0, *) {
                TextField("Search for repositories...", text: $repoSearchInput)
                    .modifier(ManropeFont(fName: .regular, size: 12))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .onSubmit {
                        handleSearchButtonClicked()
                    }
            } else {
                // Fallback on earlier versions
                TextField("Search for repositories...", text: $repoSearchInput)
                    .modifier(ManropeFont(fName: .regular, size: 12))
            }
        }
        .padding(10)
        .background(Color.white)
        .border(.gray)
        .frame(height: 38)
        .cornerRadius(3)
    }
    
    var listView: some View {
        List(repositoriesVM.repoList, id: \.id) { repo in
            RepoListCell(repoInfo: repo)
        }
    }
    
    func handleSearchButtonClicked() {
        guard !repoSearchInput.isEmpty else {
            handleShowAlert(message: "Search field cannot be empty")
            return
        }
        
        hideKeyboard()
        showLoader()
        repositoriesVM.searchRepo(searchText: repoSearchInput) { response in
            hideLoader()
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    guard let repoItems = data.items, !repoItems.isEmpty else {
                        //
                        hideTableView = true
                        searchRepoText = RepositoriesView.emptySearchRepoText
                        return
                    }
                    repositoriesVM.repoList = repoItems
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
struct RepoListCell: View {
    
    var repoInfo: Item
    
    var body: some View {
        //
        VStack(alignment: .leading, spacing: 10) {
            
            HStack() {
                
                AnimatedImage(url: URL(string: repoInfo.owner?.avatarURL ?? "")) // URL image
                    .placeholder {
                        Circle().foregroundColor(.gray)
                    }
                    .transition(.fade)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .cornerRadius(15)
                HStack(spacing: 0.5) {
                    let fullName = repoInfo.fullName ?? ""
                    let fullNameSplit = fullName.components(separatedBy: "/")
                    Text((fullNameSplit.first ?? "") + "/") // Name, ink color
                        .foregroundColor(Color("inkColor"))
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 12))
                    Text(fullNameSplit.last ?? "") // Name, black color
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .semibold, size: 12))
                }
                Spacer()
                HStack() {
                    
                    HStack(spacing: 3) {
                        Image("star")
                            .scaledToFit()
                            .frame(height: 12)
                        Text("\(repoInfo.stargazersCount ?? 0)") // Star
                            .lineLimit(1)
                            .modifier(ManropeFont(fName: .regular, size: 10))
                    }
                    HStack(spacing: 3) {
                        Circle()
                            .fill(Color("lightGreen"))
                            .scaledToFit()
                            .frame(height: 12)
                        Text(repoInfo.language ?? "-") // Language
                            .lineLimit(1)
                            .modifier(ManropeFont(fName: .regular, size: 10))
                    }
                }
            }
            
            Text(repoInfo.description ?? "No description") // Desc
                .lineLimit(2)
                .modifier(ManropeFont(fName: .regular, size: 12))
            
            HStack {
                ForEach(repoInfo.topics?.prefix(4) ?? [""]) { topic in
                    Text(topic ?? "")
                        .padding(8.0)
                        .background(Color("cyan2Bg"))
                        .foregroundColor(Color("cyan2Text"))
                        .cornerRadius(6)
                        .lineLimit(1)
                }
            }
            .modifier(ManropeFont(fName: .semibold, size: 10))
        }
    }
    
}

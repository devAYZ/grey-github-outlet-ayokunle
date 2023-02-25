//
//  RepositoriesView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct RepositoriesView: View {
    
    @Binding var repoSearchInput: String
    @State var hideTableView = true
    static let beginSearchRepoText = "Search Github for repositories, issues and pull requests!"
    static let emptySearchRepoText = "We’ve searched the ends of the earth, repository not found, please try again"
    @State var searchRepoText = beginSearchRepoText
    
    @ObservedObject var repositoriesVM = RepositoriesViewModel()
    @State private var showSearchInputAlert = false
    
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
                        Text("Repositories")
                            .modifier(ManropeFont(fName: .bold, size: 20))
                    }
                }
            }
            .alert(isPresented: $showSearchInputAlert) {
                Alert(title: Text(""), message: Text("Search field cannot be empty"))
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
    
    var tableView: some View {
        List {
            ForEach(repositoriesVM.repoList) { repo in
                Text(repo.fullName ?? "")
            }
            .modifier(ManropeFont(fName: .medium, size: 13))
        }
    }
    
    func handleSearchButtonClicked() {
        guard !repoSearchInput.isEmpty else {
            showSearchInputAlert = true
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
                    print(error.errorDescription ?? "")
                }
            }
        }
    }
    
}

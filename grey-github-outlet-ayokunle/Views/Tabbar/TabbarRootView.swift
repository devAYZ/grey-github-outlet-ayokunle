//
//  TabbarRootView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import SwiftUI

struct TabbarRootView: View {
    
    @State private var selectedTab: SelectedTab = .home
    @State private var repoInfo = ""
    
    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab) // Veiw 1
                    .tabItem {
                        Text("Home")
                        if selectedTab == .home {
                            Image("home")
                        } else {
                            Image("home0")
                        }
                    }
                    .tag(SelectedTab.home)
                RepositoriesView(repoSearchInput: $repoInfo)
                    .tabItem {
                        Text("Repositories")
                        if selectedTab == .repo{
                            Image("searchSelected")
                        } else {
                            Image("search-normal")
                        }
                    }
                    .tag(SelectedTab.repo)
                UsersView(userSearchInput: $repoInfo)
                    .tabItem {
                        Text("Users")
                        if selectedTab == .users {
                            Image("userSelected")
                        } else {
                            Image("user")
                        }
                    }
                    .tag(SelectedTab.users)
            }
            .accentColor(.black)
            .onAppear {
                UITabBar.appearance().backgroundColor = .white // default is white though
            }
    }
    
    /*
    init() {
        for family in UIFont.familyNames {
            
             print(family)
            
             for names in UIFont.fontNames(forFamilyName: family) {
             
                 print("== \(names)")
             }
        }
    }
     /*
    Manrope
    == Manrope-Regular
    == Manrope-ExtraLight
    == Manrope-Light
    == Manrope-Medium
    == Manrope-SemiBold
    == Manrope-Bold
    == Manrope-ExtraBold
     */
    */

}

struct TabbarRootView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarRootView()
    }
}

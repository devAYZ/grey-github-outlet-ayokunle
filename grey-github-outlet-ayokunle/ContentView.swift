//
//  ContentView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = "home"
    
    var body: some View {
            TabView(selection: $selectedTab) {
                HomeVC(selectedTab: $selectedTab) // Veiw 1
                    .tabItem {
                        Image("home")
                        Text("Home")
                    }
                    .tag("home")
                RepositoriesVC()
                    .tabItem {
                        Image("search-normal")
                        Text("Repositories")
                    }
                    .tag("repo")
                UsersVC()
                    .tabItem {
                        Image("user")
                        Text("Users")
                    }
                    .tag("users")
            }
            .accentColor(.black)
            .onAppear {
                UITabBar.appearance().backgroundColor = .white // default is white though
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  RepositoriesVC.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct RepositoriesVC: View {
    
    static let emptyText = "Search Github for repositories, issues and pull requests!"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Image("search-large")
                    Text(RepositoriesVC.emptyText)
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Repositories").font(.title).fontWeight(.bold)
                    }
                }
            }
        }
    }
}

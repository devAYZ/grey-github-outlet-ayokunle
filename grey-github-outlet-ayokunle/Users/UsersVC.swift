//
//  UsersVC.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/20/23.
//

import Foundation
import SwiftUI

struct UsersVC: View {
    
    static let emptyText = "Search Github for users..."
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Image("search-large")
                    Text(UsersVC.emptyText)
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        Text("Users").font(.title).fontWeight(.bold)
                    }
                }
            }
        }
    }
}

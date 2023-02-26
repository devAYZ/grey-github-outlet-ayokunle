//
//  UserDetailView.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/26/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailView: View {
    
    @ObservedObject var userDetailsVM = UserDetailViewModel()
    @State var userDetail: Item
    
    @State private var showAlert = false
    @State private var showAlertText = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .center, spacing: 15) {
                
                AnimatedImage(url: URL(string: userDetailsVM.userDetail.avatarURL ?? "")) // URL image
                    .placeholder {
                        Circle().foregroundColor(.gray)
                    }
                    .transition(.fade)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 46)
                    .cornerRadius(23)
                
                //
                VStack(alignment: .leading, spacing: 7) {
                    VStack(alignment: .leading) {
                        Text(userDetailsVM.userDetail.name ?? "") // Name
                            .lineLimit(1)
                            .modifier(ManropeFont(fName: .semibold, size: 16))
                        Text(userDetailsVM.userDetail.bio ?? "No Bio") // Info
                            .lineLimit(1)
                            .modifier(ManropeFont(fName: .regular, size: 13))
                    }
                }
                Spacer()
            }
            
            Text(userDetailsVM.userDetail.bio ?? "No Description") // Desc
                .lineLimit(3)
                .modifier(ManropeFont(fName: .regular, size: 12))
            
            HStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Label(userDetailsVM.userDetail.location ?? "", image: "location")
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .semibold, size: 10))
                        .foregroundColor(.secondary)
                    Label("\(userDetailsVM.userDetail.followers ?? 0)" + " followers.", image: "people")
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 11))
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Label(userDetailsVM.userDetail.htmlURL ?? "", image: "link")
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .semibold, size: 10))
                        .foregroundColor(.black)
                    Text("\(userDetailsVM.userDetail.following ?? 0)"  + " following") // Info
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .regular, size: 11))
                        .foregroundColor(.secondary)
                }
            }
            VStack(alignment: .leading, spacing: 3) { // Repo Stack
                HStack {
                    Text("Repositories") // Desc
                        .lineLimit(1)
                        .modifier(ManropeFont(fName: .medium, size: 15))
                    Text("\(userDetailsVM.userDetail.publicRepos ?? 0)" )
                        .modifier(ManropeFont(fName: .medium, size: 11))
                        .frame(width: 27)
                        .padding(2)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        .lineLimit(1)
                }
                Divider()
            }
            
            
            
            Spacer() // Bottom Spacer
        }
        .padding()
        .onAppear {
            handleFetchUserDetails(userDetail.login ?? "")
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""), message: Text(showAlertText))
        }
    }
    
    func handleFetchUserDetails(_ userLogin: String) {
        showLoader()
        userDetailsVM.getUserDetail(userLogin: userLogin) { response in
            hideLoader()
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    userDetailsVM.userDetail = data
                case .failure(let error):
                    handleShowAlert(message: error.errorDescription ?? "")
                }
            }
        }
    }
    
    func handleShowAlert(message: String) {
        showAlertText = message
        showAlert = true
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(userDetail: UserDetailViewModel.shared.userDetail)
    }
}

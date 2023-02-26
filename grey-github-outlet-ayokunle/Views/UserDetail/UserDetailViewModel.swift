//
//  UserDetailViewModel.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/26/23.
//

import Foundation
import SwiftUI

class UserDetailViewModel: ObservableObject {
    
    static let shared = UserDetailViewModel()
    @Published var userDetail = Item()
    
    func getUserDetail(userLogin: String, completion: @escaping (NetworkResponseType<Item>) -> Void) {
        NetworkCall.shared.makeAPICall(with: getUserDetailRequestObject(userLogin: userLogin)) { response in
            completion(response)
        }
    }
}

extension UserDetailViewModel {
    /// User DetailsRequest Object
    private func getUserDetailRequestObject(userLogin: String)
    -> NetworkCallModel<EmptyRequest, Item> {
        
        let endpoint = Endpoints.getUser.rawValue.replacingOccurrences(of: "{userLogin}", with: userLogin)
        
        return NetworkCallModel(
            endpoint: endpoint,
            requestMethod: .get,
            requestObject: EmptyRequest(),
            responseType: Item.self
        )
    }
}

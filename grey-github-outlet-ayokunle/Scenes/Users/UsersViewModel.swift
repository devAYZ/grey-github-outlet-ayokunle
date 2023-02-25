//
//  UsersViewModel.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Alamofire
import Foundation

class UsersViewModel: ObservableObject {
    
    @Published var usersList = [Item]()
    
    func searchUsers(searchText: String, completion: @escaping (DataResponse<RepositoriesResponse, AFError>) -> Void) {
        NetworkCall.shared.makeAPICall(with: getUserRequestObject(searchText: searchText)) { response in
            completion(response)
        }
    }
}

extension UsersViewModel {
    /// Users Request Object
    private func getUserRequestObject(searchText: String)
    -> NetworkCallModel<EmptyRequest, RepositoriesResponse> {
        
        let queryParams = QueryParameters(value: ["q": searchText])
        
        return NetworkCallModel(
            endpoint: Endpoints.searchUsers.rawValue,
            requestMethod: .get,
            requestObject: EmptyRequest(),
            responseType: RepositoriesResponse.self,
            queryparameters: queryParams
        )
    }
}

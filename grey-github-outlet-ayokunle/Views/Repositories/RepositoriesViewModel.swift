//
//  RepositoriesViewModel.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation

class RepositoriesViewModel: ObservableObject {
    
    static let shared = RepositoriesViewModel()
    @Published var repoList = [Item]()
    
    func searchRepo(searchText: String, completion: @escaping (NetworkResponseType<RepositoriesResponse>) -> Void) {
        NetworkCall.shared.makeAPICall(with: getRepositoriesRequestObject(searchText: searchText)) { response in
            completion(response)
        }
    }
}

extension RepositoriesViewModel {
    /// Repositories Request Object
    private func getRepositoriesRequestObject(searchText: String)
    -> NetworkCallModel<EmptyRequest, RepositoriesResponse> {
        
        let queryParams = QueryParameters(value: ["q": searchText])
        
        return NetworkCallModel(
            endpoint: Endpoints.searchRepos.rawValue,
            requestMethod: .get,
            requestObject: EmptyRequest(),
            responseType: RepositoriesResponse.self,
            queryparameters: queryParams
        )
    }
}

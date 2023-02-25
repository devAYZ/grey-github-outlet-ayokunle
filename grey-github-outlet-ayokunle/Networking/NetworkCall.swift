//
//  NetworkCall.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation
import Alamofire

public protocol NetworkCallProtocol {
    /// Make API Call, Generic Method
    /// - Parameters:
    ///   - requestModel: Request Model Object
    ///   - completion: Use/Switch the response result
    func makeAPICall<Q: Codable, A: Decodable>(
        with requestModel: NetworkCallModel<Q, A>, completion: @escaping (DataResponse<A, AFError>) -> Void
    )
}

class NetworkCall: NetworkCallProtocol {
    
    static let shared = NetworkCall()
    
    // MARK: API call
    func makeAPICall<Q: Decodable, A: Decodable>(with requestModel: NetworkCallModel<Q, A>, completion: @escaping (DataResponse<A, AFError>) -> Void) {
        
        let schemeMode = SchemeMode(rawValue: InfoPlistParser.getStringValue(key: "SCHEME_MODE"))
        let urlScheme = Endpoints.https.rawValue
        let baseUrl = InfoPlistParser.getStringValue(key: "BASE_URL")
        let urlPath = requestModel.endpoint
        
        let requestObject =  requestModel.requestObject
        let requestMethod = requestModel.requestMethod
        let responseType = requestModel.responseType
        let requestUrl = urlScheme + baseUrl + urlPath
        var requestHeaders: HTTPHeaders = [
            "content-type": "application/json",
            "x-channel": "iOS",
            "x-entity": "NG",
            "X-App-Version": InfoPlistParser.getStringValue(key: "CFBundleShortVersionString"),
            "x-lang": "EN"
        ]
        requestModel.headers?.forEach {
            requestHeaders.update($0)
        }
        
        let request = AF.request(requestUrl, method: requestMethod,
                                 parameters: requestObject,
                                 encoder: JSONParameterEncoder.default,
                                 headers: requestHeaders) { urlRequest in
        }
        
        request.responseDecodable(of: responseType) { response in
            
            if schemeMode == .development { debugPrint(response) }
            
            completion(response)
        }
    }
}

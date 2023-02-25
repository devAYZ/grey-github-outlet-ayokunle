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
        
        let requestUrl = urlScheme + baseUrl + urlPath
        let requestObject =  requestModel.requestObject
        let requestMethod = requestModel.requestMethod
        let responseType = requestModel.responseType
        let requestQueryParams = requestModel.queryparameters?.value
        
        var requestHeaders: HTTPHeaders = [
            "content-type": "application/json",
            "x-channel": "iOS",
            "x-entity": "NG",
            "X-App-Version": InfoPlistParser.getStringValue(key: "CFBundleShortVersionString"),
            "x-lang": "EN"
        ]
        requestModel.headers?.value.forEach {
            requestHeaders.update($0)
        }
        
        var request = AF.request(requestUrl)
        
        if requestMethod == .get {
            request = AF.request(requestUrl, method: requestMethod,
                                 parameters: requestQueryParams,
                                 encoding: URLEncoding.default,
                                 headers: requestHeaders) { urlRequest in
                // urlRequest
            }
        } else {
            request = AF.request(requestUrl, method: requestMethod,
                                 parameters: requestObject,
                                 encoder: .json, //JSONParameterEncoder.default
                                 headers: requestHeaders) { urlRequest in
                // urlRequest
            }
        }
        
        if schemeMode == .development {
            debugPrint("Endpoint: ", requestUrl)
        }
        
        request.responseDecodable(of: responseType) { response in
            
            if schemeMode == .development { debugPrint(response) }
            
            completion(response)
        }
    }
}

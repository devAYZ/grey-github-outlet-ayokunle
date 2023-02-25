//
//  NetworkCallModel.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation
import Alamofire

/// Request Model , (Q: Question) Request Type , (A: Answer) Response Type
public struct NetworkCallModel<Q: Codable, A:Decodable> {
    
    /// <#Description#>
    /// - Parameters:
    ///   - url: The endpoint to be call
    ///   - requestMethod: HTTP request method
    ///   - requestObject: (Q: Question) Request Object
    ///   - responseType: (A: Answer) Response Object
    ///   - header:
    public init(
        endpoint: String, requestMethod: HTTPMethod, requestObject: Q? = nil,
        responseType: A.Type, headers: HTTPHeaders? = nil
    ) {
        self.endpoint = endpoint
        self.requestMethod = requestMethod
        self.requestObject = requestObject
        self.responseType = responseType
        self.headers = headers
    }
    
    public var endpoint: String
    public var requestMethod: HTTPMethod
    public var requestObject: Q?
    public var responseType: A.Type
    public var headers: HTTPHeaders?
}

struct NetworkHeaders {
    var headers: HTTPHeaders
}

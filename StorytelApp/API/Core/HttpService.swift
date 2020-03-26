//
//  HttpService.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
}

/// A service to perform HTTP requests.
class HttpService {
    /// Provides a default instance of HttpService.
    static let `default` = HttpService()
    
    func getRequest(url: String, parameters: [String : String]) -> HttpRequest {
        return request(method: .get,
                       url: url,
                       parameters: parameters)
    }
    
    func postRequest(url: String, data: [String : String]) -> HttpRequest {
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(data) else {
            fatalError("Unable to encode post data")
        }
        
        return request(method: .post,
                       url: url,
                       parameters: [:],
                       headers: ["Content-Type" : "application/json"],
                       postData: jsonData)
    }
    
    /// Creates and returns a GET HttpRequest with given url and parameters.
    ///
    /// - Parameter url: An url string.
    /// - Parameter parameters: A dictionary with query parameters.
    private func request(method: HttpMethod, url: String, parameters: [String : String], headers: [String : String]? = nil, postData: Data? = nil) -> HttpRequest {
        guard var urlComponents = URLComponents(string: url) else {
            /// Should never happen.
            fatalError("Invalid url.")
        }
        
        urlComponents.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        guard let url = urlComponents.url else {
            /// Should never happen.
            fatalError("Unable to format url with given parameters.")
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let headers = headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = postData
        
        return HttpRequest(request: urlRequest)
    }
}


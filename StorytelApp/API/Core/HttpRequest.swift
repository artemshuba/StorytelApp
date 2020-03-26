//
//  HttpRequest.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

enum HttpError : Error {
    case clientError(statusCode: Int)
}

/// Represents HTTP request.
struct HttpRequest {
    private let request: URLRequest
    
    /// Initializes HttpRequest with provided URLRequest.
    init(request: URLRequest) {
        self.request = request
    }
    
    /// Performs a request and returns response as Data.
    ///
    /// - Parameter completion: A closure to handle a response.
    func responseData(completion: @escaping (Result<Data?, Error>) -> (Void)) {
        perform(request, completion: completion)
    }

    private func perform(_ request: URLRequest, completion: @escaping (Result<Data?, Error>) -> ()) {
        print("Request: \(request.url?.absoluteString ?? "")")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 400..<600:
                    completion(.failure(HttpError.clientError(statusCode: httpResponse.statusCode)))
                    return
                default:
                    break
                }
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

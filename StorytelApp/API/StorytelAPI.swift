//
//  StorytelAPI.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

private let apiBase = "https://api.storytel.net"

protocol BooksApiService {
    func fetchBooks(query: String, page: String?, completion: @escaping (Result<BooksResponse, Error>) -> Void)
}

enum ApiServiceError : Error {
    case noData
    case invalidResponse(Error)
}

class StorytelBooksApiService : BooksApiService {
    // MARK: - Properties: private
    
    private let httpService: HttpService
    
    // MARK: - Init
    
    init(httpService: HttpService) {
        self.httpService = httpService
    }
    
    // MARK: - Public
    
    func fetchBooks(query: String, page: String? = nil, completion: @escaping (Result<BooksResponse, Error>) -> Void) {
        var parameters = [
            "query": query
        ]
        
        if let page = page {
            parameters["page"] = page
        }
        
        httpService.getRequest(
            url: "\(apiBase)/search",
            parameters: parameters).responseData { [weak self] result in
                self?.handle(result: result, completion: completion)
            }
    }
    
    // MARK: - Private
    
    private func handle<T>(result: Result<Data?, Error>,
                                   completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        
        switch result {
        case .failure(let error):
            completion(.failure(error))
            
        case .success(let data):
            guard let data = data else {
                completion(.failure(ApiServiceError.noData))
                return
            }
            
//            print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                
                completion(.failure(ApiServiceError.invalidResponse(error)))
            }
        }
    }
}

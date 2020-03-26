//
//  MockBooksApiService.swift
//  StorytelAppTests
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
@testable import StorytelApp

class MockBooksApiService : BooksApiService {
    var books: [Book]?
    
    func fetchBooks(query: String, page: String?, completion: @escaping (Result<BooksResponse, Error>) -> Void) {
        // Simulate request using delay
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            
            guard let books = self.books else {
                completion(.failure(ApiServiceError.noData))
                return
            }
            
            completion(.success(BooksResponse(query: query, items: books, nextPageToken: "")))
        }
    }
}

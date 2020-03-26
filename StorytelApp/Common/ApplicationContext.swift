//
//  ApplicationContext.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class ApplicationContext {
    static let `default` = ApplicationContext(
        booksService: StorytelBooksApiService(httpService: .default)
    )
    
    let booksService: BooksApiService
    
    init(booksService: BooksApiService) {
        self.booksService = booksService
    }
}

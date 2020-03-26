//
//  BookViewModel.swift
//  StorytelApp
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

struct BookViewModel {
    let title: String
    
    let displayAuthors: String
    
    let displayNarrators: String
    
    let coverUrl: URL?
    
    init(book: Book) {
        self.title = book.title
        
        if !book.authors.isEmpty {
            self.displayAuthors = "By: \(book.authors.map({ $0.name }).joined(separator: ", "))"
        } else {
            self.displayAuthors = ""
        }
        
        if !book.narrators.isEmpty {
            self.displayNarrators = "With: \(book.narrators.map({ $0.name }).joined(separator: ", "))"
        } else {
            self.displayNarrators = ""
        }
        
        coverUrl = URL(string: book.cover.url)
    }
}

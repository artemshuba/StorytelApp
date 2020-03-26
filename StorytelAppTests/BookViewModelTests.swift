//
//  BookViewModelTests.swift
//  StorytelAppTests
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import XCTest
@testable import StorytelApp

class BookViewModelTests: XCTestCase {
    func testSingleAuthorDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [
                            BookPerson(id: "", name: "Author 1"),
                        ],
                        narrators: [],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayAuthors, "By: Author 1")
    }
    
    func testMultipleAuthorsDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [
                            BookPerson(id: "", name: "Author 1"),
                            BookPerson(id: "", name: "Author 2"),
                            BookPerson(id: "", name: "Author 3"),
                        ],
                        narrators: [],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayAuthors, "By: Author 1, Author 2, Author 3")
    }
    
    func testEmptyAuthorsDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [],
                        narrators: [],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayAuthors, "")
    }
    
    func testSingleNarratorDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [],
                        narrators: [
                            BookPerson(id: "", name: "Narrator 1"),
                        ],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayNarrators, "With: Narrator 1")
    }

    func testMultipleNarratorsDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [],
                        narrators: [
                            BookPerson(id: "", name: "Narrator 1"),
                            BookPerson(id: "", name: "Narrator 2"),
                            BookPerson(id: "", name: "Narrator 3"),
                        ],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayNarrators, "With: Narrator 1, Narrator 2, Narrator 3")
    }
    
    func testEmptyNarratorsDisplayString() throws {
        let book = Book(id: "",
                        title: "",
                        authors: [],
                        narrators: [],
                        cover: BookImage(height: 0, width: 0, url: ""))
        
        let viewModel = BookViewModel(book: book)
        
        XCTAssertEqual(viewModel.displayNarrators, "")
    }
}

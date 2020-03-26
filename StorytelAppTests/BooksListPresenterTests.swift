//
//  BooksListPresenterTests.swift
//  StorytelAppTests
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import XCTest
@testable import StorytelApp

class BooksListPresenterTests: XCTestCase {
    private let booksService = MockBooksApiService()
    private let view = MockBooksListView()
    private lazy var presenter = BooksListPresenter(query: "query", booksService: booksService)
    
    override func setUpWithError() throws {
        var sampleBooks: [Book] = []
        
        for i in 0 ..< 25 {
            sampleBooks.append(
                Book(id: "\(i)", title: "Book \(i)", authors: [], narrators: [], cover: BookImage(height: 0, width: 0, url: ""))
            )
        }
        
        booksService.books = sampleBooks
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testActivityIsUpdated() {
        //Given
        let expectation1 = self.expectation(description: "IsFetching must be updated to true")
        let expectation2 = self.expectation(description: "IsFetching must be updated to false")
        var isFetching: Bool = false

        view.onActivityUpdated = { isLoading in
            isFetching = isLoading
            isLoading ? expectation1.fulfill() : expectation2.fulfill()
        }
        
        presenter.view = view

        presenter.load()

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertEqual(isFetching, false)
    }
    
    func test25BooksFetched() throws {
        let expectation = self.expectation(description: "25 books should be fetched")
        
        view.onShowBooks = {
            expectation.fulfill()
        }
        
        presenter.view = view
        
        presenter.load()
        
        waitForExpectations(timeout: 2, handler: nil)
        
        let numberOfFetchedBooks = presenter.numberOfBooks()
        
        XCTAssertEqual(numberOfFetchedBooks, 25)
    }
    
    func test25MoreBooksFetched() throws {
        let expectation = self.expectation(description: "50 books in total should be fetched")
        var isLoadedMore = false
        
        view.onShowBooks = {
            guard !isLoadedMore else {
                expectation.fulfill()
                return
            }
            
            isLoadedMore = true
            
            DispatchQueue.main.async {
                self.presenter.loadMore()
            }
        }
        
        presenter.view = view
        
        presenter.load()
        
        waitForExpectations(timeout: 4, handler: nil)

        let numberOfFetchedBooks = presenter.numberOfBooks()
        
        XCTAssertEqual(numberOfFetchedBooks, 50)
    }
}

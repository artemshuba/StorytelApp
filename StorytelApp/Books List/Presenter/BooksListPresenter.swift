//
//  BooksListPresenter.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

protocol BooksListPresenterProtocol : Presenter {
    var view: BooksListView? { get set }
    
    func numberOfBooks() -> Int
    
    func book(at indexPath: IndexPath) -> BookViewModel
    
    func loadMore()
}

class BooksListPresenter : BooksListPresenterProtocol {
    // MARK: - Properties: private
    
    private let booksService: BooksApiService
    
    private let query: String
    private var books: [BookViewModel] = []
    private var nextPageToken: String?
    
    private var isLoading = false {
        didSet {
            isLoading ? view?.startActivity() : view?.stopActivity()
        }
    }
    
    private var isLoadingMore = false {
        didSet {
            isLoadingMore ? view?.startMoreActivity() : view?.stopMoreActivity()
        }
    }
    
    // MARK: - Properties: private
    
    weak var view: BooksListView?
    
    // MARK: - Init
    
    init(query: String, booksService: BooksApiService) {
        self.query = query
        self.booksService = booksService
    }
    
    // MARK: - Public
    
    func load() {
        loadBooks()
    }
    
    func loadMore() {
        loadMoreBooks()
    }
    
    func numberOfBooks() -> Int {
        books.count
    }
    
    func book(at indexPath: IndexPath) -> BookViewModel {
        books[indexPath.row]
    }
    
    // MARK: - Private
    
    private func loadBooks() {
        isLoading = true
        
        booksService.fetchBooks(query: query, page: nil) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let response):
                    strongSelf.books = strongSelf.processBooks(response.items)
                    strongSelf.nextPageToken = response.nextPageToken
                    strongSelf.view?.showBooks(withQuery: response.query)
                    
                case .failure(let error):
                    let alert = Alert(for: error)
                    
                    strongSelf.view?.showAlert(alert)
                }
                
                strongSelf.isLoading = false
            }
        }
    }
    
    private func loadMoreBooks() {
        guard !isLoading && !isLoadingMore else { return }
        
        isLoadingMore = true
        
        booksService.fetchBooks(query: query, page: nextPageToken) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let response):
                    strongSelf.books.append(contentsOf: strongSelf.processBooks(response.items))
                    strongSelf.nextPageToken = response.nextPageToken
                    strongSelf.view?.showBooks(withQuery: response.query)
                    
                case .failure:
                    // Do nothing since it's an incremental loading
                    break
                }
                
                strongSelf.isLoadingMore = false
            }
        }
    }
    
    private func processBooks(_ books: [Book]) -> [BookViewModel] {
        books.map { BookViewModel(book: $0) }
    }
}

//
//  BooksListViewBuilder.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class BooksListViewBuilder {
    static func build(withQuery query: String, appContext: ApplicationContext) -> BooksListViewController {
        let presenter = BooksListPresenter(query: query, booksService: appContext.booksService)
        let viewController = BooksListViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}

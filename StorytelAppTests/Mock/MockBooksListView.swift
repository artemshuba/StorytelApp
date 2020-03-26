//
//  MockBooksListView.swift
//  StorytelAppTests
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
@testable import StorytelApp

class MockBooksListView : BooksListView {
    var onShowBooks: (() -> Void)?
    var onActivityUpdated: ((Bool) -> Void)?
    
    func showBooks(withQuery query: String) {
        onShowBooks?()
    }
    
    func showAlert(_ alert: Alert) {
        
    }
    
    func startActivity() {
        onActivityUpdated?(true)
    }
    
    func stopActivity() {
        onActivityUpdated?(false)
    }
    
    func startMoreActivity() {
        
    }
    
    func stopMoreActivity() {
        
    }
}

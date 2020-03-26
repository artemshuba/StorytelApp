//
//  BooksResponse.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

struct BooksResponse : Codable {
    let query: String
    
    let items: [Book]
    
    let nextPageToken: String
}

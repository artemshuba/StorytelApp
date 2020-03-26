//
//  Book.swift
//  StorytelApp
//
//  Created by Artem Shuba on 24/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

struct Book : Codable {
    let id: String
    
    let title: String
    
    let authors: [BookPerson]
    
    let narrators: [BookPerson]
    
    let cover: BookImage
}

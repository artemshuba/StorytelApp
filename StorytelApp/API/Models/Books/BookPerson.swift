//
//  BookPerson.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

// A person related to book (author or narrator)
struct BookPerson : Codable {
    let id: String
    
    let name: String
}

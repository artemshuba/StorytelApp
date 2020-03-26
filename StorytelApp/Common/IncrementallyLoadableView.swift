//
//  IncrementallyLoadableView.swift
//  StorytelApp
//
//  Created by Artem Shuba on 26/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

protocol IncrementallyLoadableView {
    func startMoreActivity()
    
    func stopMoreActivity()
}

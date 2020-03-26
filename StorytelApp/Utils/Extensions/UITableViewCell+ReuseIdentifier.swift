//
//  UITableViewCell+ReuseIdentifier.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Reuse identifier for cell
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    /// Nib for cell
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

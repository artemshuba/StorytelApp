//
//  PresenterView.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

/// Common protocol for all views used in presenter
protocol PresenterView : class {
    /// Shows alert.
    ///
    /// - Parameter alert: An alert model.
    func showAlert(_ alert: Alert)
}

//
//  Alert.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

struct Alert {
    typealias Action = (title: String, style: UIAlertAction.Style)
    typealias ActionHandler = (() -> ())
    
    let title: String?
    let message: String?
    let primaryAction: Action
    let primaryActionHandler: ActionHandler?
    
    init(title: String?, message: String?, primaryAction: Action, primaryActionHandler: ActionHandler? = nil) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.primaryActionHandler = primaryActionHandler
    }
    
    init(for error: Error, primaryActionHandler: ActionHandler? = nil) {
        let title: String = Alert.errorDefaultTitle
        let message: String = Alert.errorDefaultMessage
        
        self.init(title: title, message: message, primaryAction: ("OK", .default), primaryActionHandler: primaryActionHandler)
    }
}

extension Alert {
    static var errorDefaultTitle: String {
        "Error"
    }
    
    static var errorDefaultMessage: String {
        "An error occurred.\nPlease wait and try again."
    }
}

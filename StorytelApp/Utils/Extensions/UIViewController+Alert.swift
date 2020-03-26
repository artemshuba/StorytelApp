//
//  UIViewController+Alert.swift
//  StorytelApp
//
//  Created by Artem Shuba on 25/03/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ alert: Alert) {
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: alert.primaryAction.title,
                                                style: alert.primaryAction.style,
                                                handler: { _ in alert.primaryActionHandler?() } ))
        
        present(alertController, animated: true, completion: nil)
    }
}

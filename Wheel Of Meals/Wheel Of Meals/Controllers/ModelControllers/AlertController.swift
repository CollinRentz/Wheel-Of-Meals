//
//  AlertController.swift
//  Wheel Of Meals
//
//  Created by Collin Rentz on 1/4/23.
//

import Foundation
import UIKit

struct AlertController {

    static func presentAlertControllerWith(alertTitle: String, alertMessage: String?, dismissActionTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel, handler: nil)
        alertController.addAction(dismissAction)

        return alertController
    }
}

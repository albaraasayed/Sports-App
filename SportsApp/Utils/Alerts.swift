//
//  Alerts.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import UIKit

final class AlertManager {
    static func showNoInternetAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

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
    
    static func showDeleteConfirmationAlert(on viewController: UIViewController, title: String, message: String, confirmHandler: @escaping () -> Void, cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: String(localized: "Cancel"), style: .cancel, handler: { _ in cancelHandler?() }))
        alert.addAction(UIAlertAction(title: String(localized: "Remove"), style: .destructive, handler: { _ in confirmHandler() }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showLanguageChangeAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: { _ in
            exit(0)
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

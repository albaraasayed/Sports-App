//
//  ViewController.swift
//  SportsApp
//
//  Created by albaraa alsayed on 06/12/1447 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapStartButton() {
        let sb = UIStoryboard(name: Constants.homeVC, bundle: nil)
        let tabBarVC = sb.instantiateViewController(withIdentifier: Constants.mainTabBarController)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
}

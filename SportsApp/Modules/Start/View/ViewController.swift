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
        
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
}

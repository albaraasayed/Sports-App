//
//  UserDefaultsManager.swift
//  SportsApp
//
//  Created by albaraa alsayed on 19/12/1447 AH.
//

import Foundation


protocol UserDefaultsManagerProtocol {
    func disableOnboarding()
    func isOnboardingDisabled() -> Bool
    func changeLanguage(to language: String)
    func changeTheme(to theme: String)
}

class UserDefaultsManager : UserDefaultsManagerProtocol {
    
    let userDefaults: UserDefaults = .standard
    private init(){}
    func disableOnboarding() {
        
    }
    
    func isOnboardingDisabled() -> Bool {
        return false
    }
    
    func changeLanguage(to language: String) {
        
    }
    
    func changeTheme(to theme: String) {
        
    }
}

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
    func getTheme() -> String?
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private let onboardingKey = "hasSeenOnboarding"
    private let languageKey = "appLanguage"
    private let themeKey = "AppTheme"
    
    private init() {}
    
    func disableOnboarding() {
        userDefaults.set(true, forKey: onboardingKey)
    }
    
    func isOnboardingDisabled() -> Bool {
        return userDefaults.bool(forKey: onboardingKey)
    }
    
    func changeLanguage(to language: String) {
        userDefaults.set(language, forKey: languageKey)
    }
    
    func changeTheme(to theme: String) {
        userDefaults.set(theme, forKey: themeKey)
    }
    
    func getTheme() -> String? {
        return userDefaults.string(forKey: themeKey)
    }
}

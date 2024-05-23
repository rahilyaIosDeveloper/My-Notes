//
//  AppLanguageManager.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 22/5/24.
//

import Foundation

enum LanguageType: String {
    case kg = "ky-KG"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager {
    
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    private func setCurrentBundlePath(languageCode: String) {
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let langBundle = Bundle(path: bundlePath) else {
            return
        }
        currentBundle = langBundle
    }
    
    private func setCurrentLanguage(languageType: LanguageType) {
        currentLanguage = languageType
    }
    
    func setAppLanguage(languageType: LanguageType) {
      setCurrentLanguage(languageType: languageType)
        setCurrentBundlePath(languageCode: languageType.rawValue)
    }
}

extension String {
    func localised() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, comment: "")
    }
}

//
//  AccountStorage.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 25.11.2022.
//

import Foundation

class AccountStorage {
    
    var accountId: String? {
        get {
            guard let accountId = UserDefaults.standard.value(forKey: "accountId") as? String else {
                return nil
            }
            return accountId
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accountId")
        }
    }
    
    init() {
        
    }
}

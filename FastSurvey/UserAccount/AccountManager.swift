//
//  UserAccountManager.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 08.11.2022.
//

import Foundation

class AccountManager {
    
    static let shared = AccountManager()
    
    var token: String?
    
    lazy var router: Router = {
        return Router()
    }()
}

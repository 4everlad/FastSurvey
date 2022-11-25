//
//  UserAccountManager.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 08.11.2022.
//

import Foundation
import UIKit

class AccountManager {
    
    static let shared = AccountManager()
    
    private(set)var token: String? {
        willSet {
            guard let accountId = self.accountId else { return }
            guard let token = newValue else { return }
            SecureStorage().setToken(token: token, accountId: accountId)
        }
    }
    
    private(set)var accountId: String? {
        willSet {
            AccountStorage().accountId = newValue
        }
    }
    
    lazy var router: Router = {
        return Router()
    }()
    
    lazy var userModel: UserAccountViewModel = {
        return UserAccountViewModel()
    }()
    
    func loadAccount() {
        if let accountId = AccountStorage().accountId {
            self.accountId = accountId
        } else {
            self.accountId = UIDevice.current.identifierForVendor!.uuidString
        }
        
        guard let token = SecureStorage().getToken(accountId: self.accountId!) else {
            return
        }
        
        NetworkClient().getUserData(token: token, completion: { [weak self] (user, error) in
            if let json = user {
                DispatchQueue.main.async {
                    self?.userModel.user.update(with: json)
                    self?.router.isAuthed = true
                    self?.token = token
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func set(token: String) {
        self.token = token
    }
    
    func logOut() {
        guard let accountId = accountId else {
            return
        }
        
        SecureStorage().deleteToken(accountId: accountId)
        router.tabSelection = 0
        router.isAuthed = false
    }
    
}

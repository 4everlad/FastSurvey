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
    private let accountStorage = AccountStorage()
    private let secureStorage = SecureStorage()
    private let networkClient = NetworkClient()
    
    private(set)var token: String? {
        willSet {
            guard let accountId = self.accountId else { return }
            guard let token = newValue else { return }
            secureStorage.setToken(token: token, accountId: accountId)
        }
    }
    
    private(set)var accountId: String? {
        willSet {
            accountStorage.accountId = newValue
        }
    }
    
    lazy var navState: NavigationState = {
        return NavigationState()
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
        
        navState.isCheckingLogin = true
        
        networkClient.getUserData(token: token, completion: { [weak self] (user, error) in
            if let json = user {
                DispatchQueue.main.async {
                    self?.userModel.user.update(with: json)
                    self?.navState.isAuthed = true
                    self?.token = token
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self?.navState.isCheckingLogin = false
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
        
        secureStorage.deleteToken(accountId: accountId)
        navState.tabSelection = 0
        navState.isAuthed = false
    }
    
}

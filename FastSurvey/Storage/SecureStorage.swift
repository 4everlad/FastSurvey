//
//  KeychainWrapper.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 25.11.2022.
//

import Foundation
import KeychainWrapper

class SecureStorage {
    
    func setToken(token: String, accountId: String) {
        do {
            guard let token = token.data(using: .utf8) else { return }
            try KeychainWrapper.set(value: token, account: accountId)
        } catch {
            debugPrint("Keychain token setting error")
        }
    }
    
    func getToken(accountId: String) -> String? {
        do {
            guard let data = try KeychainWrapper.get(account: accountId) else {
                return nil
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                return nil
            }
            
            return token
        } catch {
            debugPrint("Keychain getting token error")
            return nil
        }
    }
    
    func deleteToken(accountId: String) {
        do {
            try KeychainWrapper.delete(account: accountId)
        } catch {
            debugPrint("Keychain delete token error")
        }
    }
    
    init() {
        
    }
}


//
//  LoginViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    
    @Published var email: String = "" {
        didSet {
            errorMessage = ""
        }
    }
    
    @Published var password: String = "" {
        didSet {
            errorMessage = ""
        }
    }
    
    @Published var isLoading = false
    @Published private(set)var errorMessage: String = ""
    
    func makeLogin(completion: @escaping (Bool)->(Void)) {
        
        isLoading = true
        let params = LoginParams(email: email, password: password)
        
        NetworkClient().makeLogin(params: params, completion: { result, message  in
            
            if result == true {
                self.accountManager.token = message
                completion(true)
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = message
                }
                completion(false)
            }
            
        })
    }
    
}

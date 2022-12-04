//
//  LoginViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    private let accountManager = AccountManager.shared
    private let networkClient = NetworkClient()
    
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
    
    func validateData() -> Bool {
        
        guard email.count > 0 && isValidEmail(email) else {
            errorMessage = "Enter valid email"
            return false
        }
        
        guard password.count > 0 else {
            errorMessage = "Enter password"
            return false
        }
        
        errorMessage = ""
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func makeLogin(completion: @escaping (Bool)->(Void)) {
        
        guard validateData() else { return }
        
        isLoading = true
        let params = LoginParams(email: email, password: password)
        
        networkClient.makeLogin(params: params, completion: { result, message  in
            
            if result == true {
                self.accountManager.set(token: message)
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

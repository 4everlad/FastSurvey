//
//  LoginViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading = false
    @Published private(set)var errorMessage: String = ""
    
    func makeLogin(completion: @escaping ()->(Void)) {
        
        isLoading = true
        let params = LoginParams(email: email, password: password)
        
        NetworkClient().makeLogin(params: params, completion: { message in
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = message
            }
            self.accountManager.token = message
            completion()
        })
    }
    
}

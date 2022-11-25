//
//  UserAccountViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 14.11.2022.
//

import Foundation

class UserAccountViewModel: ObservableObject {
    
    let accountManager = AccountManager.shared
    
    @Published var user: User = User()
    var isLoading = false
    
    func getUser() {
        guard let token = accountManager.token else {
            return
        }
        
        isLoading = true
        
        NetworkClient().getUserData(token: token, completion: { [weak self] (user, error) in
            if let json = user {
                DispatchQueue.main.async {
                    self?.user.update(with: json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            self?.isLoading = false
        })
    }
    
    func logOut() {
        accountManager.logOut()
    }
}

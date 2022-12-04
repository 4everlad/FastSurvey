//
//  SignupViewModel.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 05.11.2022.
//

import Foundation

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

final class SignupViewModel: ObservableObject {
    
    private let accountManager = AccountManager.shared
    private let networkClient = NetworkClient()
    
    @Published var username: String = "" {
        didSet {
            errorMessage = ""
        }
    }
    
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
    
    @Published var age: Int = 18
    @Published var gender: String = "Male"
    @Published var country: String = "ru"
    
    @Published private(set)var errorMessage: String = ""
    @Published var isLoading = false
    
    @Published var showBottomAge = false
    @Published var showBottomGender = false
    @Published var showBottomCountry = false
    
    private(set)var allGenders: [String] = Gender.allCases.map { $0.rawValue }
    private(set)var allAges: [Int] = Array<Int>(18...99)
    private(set)var allCountries = ["ru", "en", "us"]
    
    func validateData() -> Bool {
        guard username.count > 0 else {
            errorMessage = "Enter name"
            return false
        }
        
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
    
    func makeSignup(completion: @escaping (Bool)->(Void)) {
        
        guard validateData() else { return }
            
        isLoading = true
        let userData = UserDataJSON(name: username, email: email, age: age, sex: gender, countryCode: country)
        let params = SignupParams(password: password, data: userData)
        
        networkClient.makeSignup(params: params, completion: { result, message  in
            
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

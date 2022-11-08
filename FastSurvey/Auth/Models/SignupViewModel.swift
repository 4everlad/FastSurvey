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
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var age: Int = 18
    
    @Published var gender: String = "Female"
    @Published var country: String = "ru"
    
    @Published private(set)var errorMessage: String = ""
    
    private(set)var allGenders: [String] = Gender.allCases.map { $0.rawValue }
    private(set)var allAges: [Int] = Array<Int>(18...99)
    private(set)var allCountries = ["ru", "en", "us"]
    
    func makeSignup() {
        let userData = UserDataJSON(name: username, email: email, age: age, sex: gender, countryCode: country)
        
        let params = SignupParams(password: password, data: userData)
        SignupRequest(params: params).makeSignup(completion: { message in
            DispatchQueue.main.async {
                self.errorMessage = message
            }
        })
    }
    
}

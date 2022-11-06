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
    
    var allGenders: [String] = Gender.allCases.map { $0.rawValue }
    var allAges: [Int] = Array<Int>(18...99)
    var allCountries = ["ru", "en", "us"]
    
}

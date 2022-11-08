//
//  SignupJSON.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

struct UserDataJSON: Codable {
    var name: String
    var email: String
    var age: Int
    var sex: String
    var countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case name, email, age, sex, countryCode
    }
}

struct SignupParams: Codable {
    var password: String
    var data: UserDataJSON
}

struct SignupRequestJSON: Codable {
    var token: String
    
    enum CodingKeysJSON: Codable, CodingKey {
        case token
    }
}

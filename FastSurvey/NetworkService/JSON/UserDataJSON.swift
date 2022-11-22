//
//  UserDataJSON.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 22.11.2022.
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

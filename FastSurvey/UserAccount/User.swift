//
//  User.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 21.11.2022.
//

import Foundation

struct User {
    var id: String = "-1"
    var name: String = ""
    var email: String = ""
    var age: String = ""
    var sex: String = ""
    var countryCode: String = ""
    
    init() {
        
    }
    
    mutating func update(with json: UserDataJSON) {
        self.name = json.name
        self.email = json.email
        self.age = String(json.age)
        self.sex = json.sex
        self.countryCode = json.countryCode
    }
    
}

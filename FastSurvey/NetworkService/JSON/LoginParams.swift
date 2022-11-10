//
//  LoginParams.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 09.11.2022.
//

import Foundation

struct LoginParams: Codable {
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case email, password
    }
}

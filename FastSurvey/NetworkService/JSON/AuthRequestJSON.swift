//
//  SignupJSON.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

struct AuthRequestJSON: Codable {
    var token: String
    
    enum CodingKeysJSON: Codable, CodingKey {
        case token
    }
}

//
//  SignupParams.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 22.11.2022.
//

import Foundation

struct SignupParams: Codable {
    var password: String
    var data: UserDataJSON
}

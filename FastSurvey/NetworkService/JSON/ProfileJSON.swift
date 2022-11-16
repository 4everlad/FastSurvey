//
//  ProfileJSON.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 16.11.2022.
//

import Foundation

struct ProfileJSON: Codable {
    var userData: UserDataJSON
    var userSurveys: [SurveyJSON]
    
    enum CodingKeys: String, CodingKey {
        case userData, userSurveys
    }
}

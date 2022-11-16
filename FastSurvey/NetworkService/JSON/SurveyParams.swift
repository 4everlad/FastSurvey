//
//  SurveyParams.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 15.11.2022.
//

import Foundation

struct SurveyParams: Codable {
    var title: String
    var desc: String
    
    enum CodingKeys: String, CodingKey {
        case title, desc
    }
}

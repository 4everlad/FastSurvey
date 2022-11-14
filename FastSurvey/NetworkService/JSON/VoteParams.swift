//
//  VoteParams.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 11.11.2022.
//

import Foundation

struct VoteParams: Codable {
    var surveyId: String
    var vote: String
    
    enum CodingKeys: String, CodingKey {
        case surveyId, vote
    }
}

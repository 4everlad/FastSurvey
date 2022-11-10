//
//  SurveyJSON.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 09.11.2022.
//

import Foundation

struct SurveyJSON: Codable {
    var id: String
    var ownerId: String
    var data: SurveyDataJSON
    var upVotes: [String]
    var downVotes: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, ownerId, data, upVotes, downVotes
    }
}

struct SurveyDataJSON: Codable {
    var title: String
    var desc: String
    
    enum CodingKeys: String, CodingKey {
        case title, desc
    }
}

struct SurveyListJSON: Codable {
    var surveyList: [SurveyJSON]
}



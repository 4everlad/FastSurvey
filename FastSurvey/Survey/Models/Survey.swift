//
//  Survey.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation

struct Survey: Equatable, Identifiable {
    
    public var id: String { return sid }
    
    var sid: String = "-1"
    var ownerId: String = "-1"
    var title: String = "-1"
    var description: String = "-1"
    var upVotes: [String] = [String]()
    var downVotes: [String] = [String]()
    
    init() {
        
    }
    
    init(with json: SurveyJSON) {
        self.sid = json.id
        self.ownerId = json.id
        self.title = json.data.title
        self.description = json.data.desc
        self.upVotes = json.upVotes
        self.downVotes = json.downVotes
    }
}

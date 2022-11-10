//
//  Survey.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation

struct Survey: Equatable, Identifiable {
    
    public var id = UUID()
    
    var sid: String
    var ownerId: String
    var title: String
    var description: String
    var upVotesCount: Int
    var downVotesCount: Int
    
    
}

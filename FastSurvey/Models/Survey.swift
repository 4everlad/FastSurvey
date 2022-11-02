//
//  Survey.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation

struct Survey: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var upVotes: Int
    var downVotes: Int
}

//
//  Survey.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 31.10.2022.
//

import Foundation

struct Survey: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let upVotes: Int
    let downVotes: Int
}

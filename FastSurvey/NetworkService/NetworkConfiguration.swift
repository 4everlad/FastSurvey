//
//  NetworkConfiguration.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation
class NetworkConfiguration {

    private let apiUrl = "https://survey4all.herokuapp.com/"
    
    func getHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}

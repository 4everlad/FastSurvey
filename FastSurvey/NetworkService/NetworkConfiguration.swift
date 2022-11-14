//
//  NetworkConfiguration.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation
class NetworkConfiguration {

    private let apiUrl = "https://survey4all.herokuapp.com/"
    
    private var headers: [String: String] = ["Content-Type": "application/json"]
    
    private var queryItems: [String: String] = [:]
    
    func setToken(token: String) {
        headers["Authorization"] = "Bearer \(token)"
    }
    
    func setQuiryItems(items: [String: String]) {
        queryItems = items
    }
    
    func getQueryItems() -> [String: String] {
        return queryItems
    }
    
    func getHeaders() -> [String: String] {
        return headers
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}

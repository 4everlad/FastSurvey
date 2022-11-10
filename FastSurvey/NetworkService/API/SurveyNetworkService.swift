//
//  GetFeed+Extension.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 08.11.2022.
//

import Foundation

protocol SurveyNetworkService {
    func getSurveyFeed(token: String, count: Int, startAfter: String?, completion: @escaping([SurveyJSON]?, Error?)->Void)
}

extension NetworkClient: SurveyNetworkService {

    func getSurveyFeed(token: String, count: Int, startAfter: String?, completion: @escaping([SurveyJSON]?, Error?)->Void)
    {
        
        let endpoint = "feed"
        var headersDic: [String:String] = [:]
        var queryItems: [String:String] = [:]
        headersDic["Authorization"] = "Bearer \(token)"
        queryItems["count"] = String(count)
        
        if let startAfter = startAfter {
            queryItems["startAfter"] = startAfter
        }
        
        self.request(path: endpoint, method: .get, headers: headersDic, queryItems: queryItems) { (result: Result<[SurveyJSON],Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}

//
//  GetFeed+Extension.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 08.11.2022.
//

import Foundation

protocol SurveyNetworkService {
    func getSurveyFeed(token: String, count: Int, startAfter: String?, completion: @escaping([SurveyJSON]?, Error?)->Void)
    func getSurvey(token: String, id: String, completion: @escaping(SurveyJSON?, Error?)->Void)
    func makeVote(token: String, params: VoteParams, completion: @escaping (SurveyJSON?, Error?)->Void)
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
    
    func getSurvey(token: String, id: String, completion: @escaping(SurveyJSON?, Error?)->Void) {
        
        let endpoint = "survey/\(id)"
        var headersDic: [String:String] = [:]
        headersDic["Authorization"] = "Bearer \(token)"
        
        self.request(path: endpoint, method: .get, headers: headersDic) { (result: Result<SurveyJSON,Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func makeVote(token: String, params: VoteParams, completion: @escaping (SurveyJSON?, Error?)->Void) {
        
        let path = "vote"
        
        var headersDic: [String:String] = [:]
        headersDic["Authorization"] = "Bearer \(token)"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.request(path: path, method: .post, params: encodedParams, completion: { (result: Result<SurveyJSON,Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
}

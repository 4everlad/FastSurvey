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
        
        var queryItems: [String:String] = [:]
        queryItems["count"] = String(count)
        
        if let startAfter = startAfter {
            queryItems["startAfter"] = startAfter
        }
        
        self.config.setQuiryItems(items: queryItems)
        self.config.setToken(token: token)
        
        self.request(path: endpoint, method: .get) { (result: Result<[SurveyJSON],Error>) in
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
        
        self.config.setToken(token: token)
        
        self.request(path: endpoint, method: .get) { (result: Result<SurveyJSON,Error>) in
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
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.config.setToken(token: token)
        
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

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
    func createSurvey(token: String, params: SurveyParams, completion: @escaping (SurveyJSON?, Error?)->Void)
    func getUserSurveys(token: String, completion: @escaping  ([SurveyJSON]?, Error?)->Void)
    func removeSurvey(token: String, id: String, completion: @escaping(Bool, String?)->Void)
    func removeSurveyAsync(token: String, id: String) async -> Bool
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
        
        self.config = NetworkConfiguration()
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
        
        self.config = NetworkConfiguration()
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
        
        self.config = NetworkConfiguration()
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
    
    func createSurvey(token: String, params: SurveyParams, completion: @escaping  (SurveyJSON?, Error?)->Void) {
        
        let path = "surveys"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.config = NetworkConfiguration()
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
    
    func getUserSurveys(token: String, completion: @escaping  ([SurveyJSON]?, Error?)->Void) {
        
        let path = "profile"
        
        self.config = NetworkConfiguration()
        self.config.setToken(token: token)
        
        self.request(path: path, method: .get, completion: { (result: Result<ProfileJSON,Error>) in
            switch result {
            case .success(let data):
                let surveys = data.userSurveys
                completion(surveys, nil)
            case .failure(let error as CustomError):
                completion(nil, error)
            case .failure(let error):
                completion(nil, error)
            }
        })
        
    }
    
    func removeSurvey(token: String, id: String, completion: @escaping(Bool, String?)->Void) {
        
        let endpoint = "survey/\(id)"
        
        self.config = NetworkConfiguration()
        self.config.setToken(token: token)
        
        self.request(path: endpoint, method: .delete, completion: { (result: Result<SuccessResponse,Error>) in
            switch result {
            case .success(_):
                completion(true, nil)
            case .failure(let error as CustomError):
                completion(false, error.message)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        })
    }
    
    func removeSurveyAsync(token: String, id: String) async -> Bool {
        let endpoint = "survey/\(id)"
        
        self.config = NetworkConfiguration()
        self.config.setToken(token: token)

        let result = await self.requestAsync(path: endpoint, method: .delete) as Result<SuccessResponse, Error>
        switch result {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
    
    func updateSurvey(token: String, params: SurveyParams, id: String, completion: @escaping(SurveyJSON?, Error?)->Void) {
        let endpoint = "survey/\(id)"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.config = NetworkConfiguration()
        self.config.setToken(token: token)
        
        self.request(path: endpoint, method: .put, params: encodedParams, completion: { (result: Result<SurveyJSON,Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        })
        
    }
    
}

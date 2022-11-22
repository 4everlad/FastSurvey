//
//  AuthNetworkService.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 09.11.2022.
//

import Foundation

protocol AuthNetworkService {
    func makeLogin(params: LoginParams, completion: @escaping (Bool, String) -> ())
    func makeSignup(params: SignupParams, completion: @escaping (Bool, String) -> ())
}

extension NetworkClient: AuthNetworkService {
    func makeLogin(params: LoginParams, completion: @escaping (Bool, String) -> ()) {
        
        let endpoint = "signin"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.request(path: endpoint, method: .post, params: encodedParams) { (result: Result<AuthRequestJSON,Error>) in
            switch result {
            case .success(let data):
                completion(true, data.token)
            case .failure(let error as CustomError):
                completion(false, error.message)
            case .failure(_):
                completion(false, "")
            }
        }
    }
    
    func makeSignup(params: SignupParams, completion: @escaping (Bool, String) -> ()) {
        
        let endpoint: String = "signup"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.request(path: endpoint, method: .post, params: encodedParams) { (result: Result<AuthRequestJSON,Error>) in
            switch result {
            case .success(let data):
                completion(true, data.token)
            case .failure(let error as CustomError):
                completion(false, error.message)
            case .failure(_):
                completion(false, "")
            }
        }
    }
}

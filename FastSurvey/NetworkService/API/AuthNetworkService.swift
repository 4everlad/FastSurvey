//
//  AuthNetworkService.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 09.11.2022.
//

import Foundation

protocol AuthNetworkService {
    func makeLogin(params: LoginParams, completion: @escaping (String) -> ())
}

extension NetworkClient: AuthNetworkService {
    func makeLogin(params: LoginParams, completion: @escaping (String) -> ()) {
        
        let endpoint = "signin"
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        self.request(path: endpoint, method: .post, params: encodedParams) { (result: Result<SignupRequestJSON,Error>) in
            switch result {
            case .success(let data):
                completion(data.token)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}

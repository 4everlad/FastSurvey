//
//  UserAccountNetworkService.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 21.11.2022.
//

import Foundation

protocol UserNetworkService {
    func getUserData(token: String, completion: @escaping (UserDataJSON?, Error?)->())
}

extension NetworkClient: UserNetworkService {
    func getUserData(token: String, completion: @escaping (UserDataJSON?, Error?) -> ()) {
        let endpoint = "profile"
        
        self.config = NetworkConfiguration()
        self.config.setToken(token: token)
        
        self.request(path: endpoint, method: .get, completion: { (result: Result<ProfileJSON,Error>) in
            switch result {
            case .success(let data):
                let userData = data.userData
                completion(userData, nil)
            case .failure(let error as CustomError):
                completion(nil, error)
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
}



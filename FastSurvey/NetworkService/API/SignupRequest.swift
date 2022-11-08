//
//  SignupRequest.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

final class SignupRequest {
    
    let network = NetworkClient()
    let endpoint: String = "signup"
    let params: SignupParams
    
    init(params: SignupParams) {
        self.params = params
    }
    
    func makeSignup(completion: @escaping (String) -> ()) {
        
        guard let encodedParams = JsonHelper.shared.encode(value: params) else {
            return
        }
        
        network.request(path: endpoint, method: .post, params: encodedParams) { (result: Result<SignupRequestJSON,Error>) in
            switch result {
            case .success(let data):
                completion(data.token)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }

}

//
//  NetworkClient.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

//enum APIErrors: Error {
//    typealias RawValue = Int
//
//    case noInternet
//    case notAuthed
//    case badResponse(Error?)
//    case notAllowed
//    case errorBody([String: Any])
//    case badRequest
//    case noAccount
//}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

class NetworkClient {
    private let config = NetworkConfiguration()
    
    private lazy var urlSession: URLSession? = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private var urlDataTask: URLSessionDataTask? = nil
    
    func request<T:Codable>(path: String, method: Method = .get, params: [String:Any] = [:], completion: @escaping(Result<T,Error>)->Void) {
        let baseUrl = config.getBaseUrl()
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: .infinity)
        urlRequest.httpMethod = method.rawValue
        
        let headers = config.getHeaders()
        for h in headers {
            urlRequest.addValue(h.value, forHTTPHeaderField: h.key)
        }
        
        if !params.isEmpty {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            urlRequest.httpBody = httpBody
        }
        
        self.urlDataTask = urlSession?.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
//            if let error = error {
//                completion(.failure(error)
//            }
            
            if let data = data {
                
                if let decoded = JsonHelper.shared.decode(type: T.self, data: data) {
                    completion(.success(decoded))
                }
//                else {
//                    let json = String(data: data, encoding: .utf8)
//                }
                
            }
        })
        self.urlDataTask?.resume()
    }
    
    func requestAsync<T:Codable>(path: String, method: Method = .get, params: [String:Any] = [:]) async -> Result<T,Error> {
        let baseUrl = config.getBaseUrl()
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            return .failure(CustomError(message: "Wrong url"))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let headers = config.getHeaders()
        for h in headers {
            urlRequest.addValue(h.value, forHTTPHeaderField: h.key)
        }
        
        let content = try? await urlSession?.data(for: urlRequest, delegate: nil)
        if let content = content {
            let data = content.0
            let json = String(data: data, encoding: .utf8)
            if let decoded = JsonHelper.shared.decode(type: T.self, data: data) {
               return .success(decoded)
            }         }
        return .failure(CustomError(message: "Empty"))
    }
  
}

class CustomError : Error {
    var message: String = ""
    init(message: String) {
        self.message = message
    }
}

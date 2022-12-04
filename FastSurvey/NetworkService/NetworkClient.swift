//
//  NetworkClient.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkClient {
    var config = NetworkConfiguration()
    
    private lazy var urlSession: URLSession? = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 60
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private var urlDataTask: URLSessionDataTask? = nil
    
    func request<T:Codable>(path: String, method: Method = .get, params: [String:Any] = [:], completion: @escaping(Result<T,Error>)->Void) {
        
        guard let urlRequest = getUrlRequest(path: path, method: method, params: params) else {
            return
        }
        
        self.urlDataTask = urlSession?.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                      completion(.failure(CustomError(message: "No response")))
                      return
                  }
            
            guard httpResponse.statusCode == 200 else {
                if let json = String(data: data, encoding: .utf8) {
                    completion(.failure(CustomError(message: json)))
                } else {
                    completion(.failure(CustomError(message: "Error code \(httpResponse.statusCode)")))
                }
                return
            }
            
            if let decoded = JsonHelper.shared.decode(type: T.self, data: data) {
                completion(.success(decoded))
            } else if let json = String(data: data, encoding: .utf8) {
                completion(.success(SuccessResponse(message: json) as! T))
            }
           
        })
        self.urlDataTask?.resume()
    }
    
    func requestAsync<T:Codable>(path: String, method: Method = .get, params: [String:Any] = [:]) async -> Result<T,Error> {
        
        guard let urlRequest = getUrlRequest(path: path, method: method, params: params) else {
            return .failure(CustomError(message: "Wrong url request"))
        }
        
        let content = try? await urlSession?.data(for: urlRequest, delegate: nil)
        if let content = content {
            let data = content.0
            let response = content.1
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(CustomError(message: "No response"))
            }
            
            guard httpResponse.statusCode == 200 else {
                if let json = String(data: data, encoding: .utf8) {
                    return .failure(CustomError(message: json))
                } else {
                    return .failure(CustomError(message: "Error code \(httpResponse.statusCode)"))
                }
            }
            
            if let decoded = JsonHelper.shared.decode(type: T.self, data: data) {
                return .success(decoded)
            } else if let json = String(data: data, encoding: .utf8) {
                return .success(SuccessResponse(message: json) as! T)
            }
            
        }
        return .failure(CustomError(message: "No response"))
    }
    
    func getUrlRequest(path: String, method: Method, params: [String:Any]) -> URLRequest?  {
        let baseUrl = config.getBaseUrl()
        
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(path)") else {
            return nil
        }
        
        let queryItems = config.getQueryItems()
        
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        
        let headers = config.getHeaders()
        
        for h in headers {
            urlRequest.addValue(h.value, forHTTPHeaderField: h.key)
        }
        
        if !params.isEmpty {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return nil
            }
            
            urlRequest.httpBody = httpBody
        }
        
        return urlRequest
    }
  
}

class CustomError : Error {
    var message: String = ""
    
    init(message: String) {
        self.message = message
    }
}

struct SuccessResponse : Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

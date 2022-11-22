//
//  JSONHelper.swift
//  FastSurvey
//
//  Created by Dmitry Bakulin on 06.11.2022.
//

import Foundation

class JsonHelper {
    static let shared = JsonHelper()
    private lazy var decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        return decoder
    }()
    
    private lazy var encoder: JSONEncoder = {
       let encoder = JSONEncoder()
        return encoder
    }()
    
    func decode<T:Codable>(type: T.Type, data: Data)->T? {
        do {
        let content = try decoder.decode(T.self, from: data)
            return content
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func encode<T:Codable>(value: T)->[String:Any]? {
        do {
            let content = try JSONSerialization.jsonObject(with: encoder.encode(value),
                                                           options: []) as? [String: Any]
            return content
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

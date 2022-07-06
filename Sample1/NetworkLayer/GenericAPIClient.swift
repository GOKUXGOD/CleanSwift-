//
//  GenericAPIClient.swift
//  WynkDemo
//
//  Created by Nitin Upadhyay on 16/05/20.
//  Copyright © 2020 Nitin Upadhyay. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(endpoint: Endpoint, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    typealias NetworkTaskCompletionHandler<T> = (ResponseData<T>?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(endpoint: Endpoint, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let request = endpoint.request
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    if endpoint.dataType == .Data {
                        completion(data, nil)
                    }
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch let err {
                        print("error in parsing : \(err)")
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }

    func fetch<T: Decodable>(endpoint: Endpoint, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(endpoint: endpoint, decodingType: T.self) { (json , error) in

            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}

extension Data {
    func jsonData() -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [.allowFragments, .mutableContainers])
            return json
        } catch _ {
            return self
        }
    }
    
    func objectData<T:Codable>() -> (T?, Error?) {
        do {
            let responseObject = try T.self.decode(from: self)
            return (responseObject, nil)
        }
        catch let error {
            return (nil, error)
        }
    }

}
extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

//
//  Endpoint.swift
//  WynkDemo
//
//  Created by Nitin Upadhyay on 16/05/20.
//  Copyright © 2020 Nitin Upadhyay. All rights reserved.
//

import Foundation

protocol Endpoint {
    var url: URL {get}
    var httpMethod: HTTPMethod {get}
    var dataType: DataType {get}
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum DataType:String, Codable {
    case Json
    case Data
    case CodableModel
}

extension Endpoint {
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}

enum ResponseData<T> {
    case any(Any?)
    case codable(T?)
    
    func data() -> Any? {
        switch self {
        case .any(let data):
            return data
        case .codable(let data):
            return data
        }
    }
}

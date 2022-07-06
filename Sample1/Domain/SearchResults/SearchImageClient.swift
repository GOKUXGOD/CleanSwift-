//
//  SearchImageClient.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import Foundation
public class SearchImageClient: APIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getImage(endpoint: ImageEndPoint, completion: @escaping (Result<Data?, APIError>) -> Void) {
        fetch(endpoint: endpoint, decode: { data -> Data? in
            guard let result = data as? Data else { return  nil }
            return result
        }, completion: completion)
    }
}

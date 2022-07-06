//
//  SearchAPIClient.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import Foundation
public class SearchAPIClient: APIClient {    
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getSearchData(endpoint: SearchEndpoint, completion: @escaping (Result<SearchData?, APIError>) -> Void) {
        fetch(endpoint: endpoint, decode: { json -> SearchData? in
            guard let result = json as? SearchData else { return  nil }
            return result
        }, completion: completion)
    }
}

//
//  SearchNetworkService.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import Foundation

protocol SearchApiServiceProtocol {
    func fetchSearchResult(endpoint: SearchEndpoint,
                           success: ((SearchData) -> Void)?,
                           failure: ((APIError) -> Void)?)
}

final class SearchNetworkService: SearchApiServiceProtocol {
    private let networkService: SearchAPIClient

    init(networkService: SearchAPIClient) {
        self.networkService = networkService
    }

    func fetchSearchResult(endpoint: SearchEndpoint, success: ((SearchData) -> Void)?, failure: ((APIError) -> Void)?) {
        networkService.getSearchData(endpoint: endpoint) { result in
            switch result {
            case .success(let items):
                success?(items!)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}

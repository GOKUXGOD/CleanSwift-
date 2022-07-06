//
//  SearchNetworkWorker.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

public struct SearchEndpoint: Endpoint {
    var httpMethod: HTTPMethod
    var dataType: DataType
    var url: URL
}

enum SearchNetworkWorkerError: Error {
    case invalidUrl

    var localizedDescription: String {
        switch self {
        case .invalidUrl: return "Invalid Url"
        }
    }
}

typealias SearchNetworkWorkerCompletion = () -> Void

protocol SearchNetworkingWorker {
    func fetchSearchData(request: Search.SearchItems.Request,
                         completion: @escaping (Search.SearchItems.Response) -> (Void))
}

class SearchNetworkWorker: SearchNetworkingWorker {
    var searchNetworkService: SearchNetworkService?
    var dispatchGroup: DispatchGroup
    var searchData: [SearchData]
    init(searchNetworkService: SearchNetworkService) {
        self.searchNetworkService = searchNetworkService
        dispatchGroup = DispatchGroup()
        searchData = []
    }

    func fetchSearchData(request: Search.SearchItems.Request,
                         completion: @escaping (Search.SearchItems.Response) -> (Void)) {
        self.searchData = []
        let mediaTypes = request.mediaTypes
        let searchTerm = request.searchTerm
        var errorR: Error?
        for mediaType in mediaTypes {
            let entityType = request.getEntityTypeFor(mediaType)
            let url = "https://itunes.apple.com/search?term=\(searchTerm)&entity=\(entityType)"
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let url = URL(string: encodedUrl ?? "") {
                let endPoint = SearchEndpoint(httpMethod: .get, dataType: .CodableModel, url: url)
                dispatchGroup.enter()
                searchNetworkService?.fetchSearchResult(endpoint: endPoint, success: { [weak self] searchResults in
                    guard let self = self else {
                        return
                    }
                    print("\(mediaType) request success")
                    var data = searchResults
                    data.type = mediaType
                    if !searchResults.results.isEmpty {
                        self.searchData.append(data)
                    }

                    self.dispatchGroup.leave()
                }, failure: { error in
                    errorR = error
                    print("\(mediaType) request failed")
                    self.dispatchGroup.leave()
                })
            } else {
                completion(Search.SearchItems.Response(searchResults: searchData, error: SearchNetworkWorkerError.invalidUrl))
                return
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            let response = Search.SearchItems.Response(searchResults: self.searchData, error: errorR)
            completion(response)
        }
    }
}

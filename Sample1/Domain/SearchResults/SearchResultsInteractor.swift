//
//  SearchResultsInteractor.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
 

import UIKit

protocol SearchResultsBusinessLogic {
  func getSearchResults(request: SearchResults.SearchItems.Request)
}

protocol SearchResultsDataStore {
  var searchResults: [SearchData]? { get set }
}

class SearchResultsInteractor: SearchResultsBusinessLogic, SearchResultsDataStore {
  var presenter: SearchResultsPresentationLogic?
  var worker: SearchResultsWorker?
  var searchResults: [SearchData]?
  
  // MARK: Do something
    func getSearchResults(request: SearchResults.SearchItems.Request) {
        if let searchResults = searchResults {
            presenter?.presentSearchData(response: SearchResults.SearchItems.Response(searchData: searchResults))
        }
    }
}

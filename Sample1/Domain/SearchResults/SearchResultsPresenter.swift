//
//  SearchResultsPresenter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
 

import UIKit

protocol SearchResultsPresentationLogic {
  func presentSearchData(response: SearchResults.SearchItems.Response)
}

class SearchResultsPresenter: SearchResultsPresentationLogic {
  weak var viewController: SearchResultsDisplayLogic?
  
  // MARK: Do something
  
    func presentSearchData(response: SearchResults.SearchItems.Response) {
        let railItems = response.searchData.map({ iTunesRail(searchData: $0)})
        let viewModel = SearchResults.SearchItems.ViewModel(railItems: railItems)
        viewController?.displaySearchResults(viewModel: viewModel)
    }
}

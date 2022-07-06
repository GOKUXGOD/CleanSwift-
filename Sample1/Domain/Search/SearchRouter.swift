//
//  SearchRouter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

@objc protocol SearchRoutingLogic {
    func routeToMediaSelection()
    func routeToSearchResults()
}

protocol SearchDataPassing {
  var dataStore: SearchDataStore? { get set}
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
  weak var viewController: SearchViewController?
  var dataStore: SearchDataStore?
  
  // MARK: Routing
    func routeToMediaSelection() {
        let destinationVC = SelectMediaTypesViewController().configureView() as! SelectMediaTypesViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMediaSelection(source: dataStore!, destination: &destinationDS)
        navigateToMediaSelection(source: viewController!, destination: destinationVC)
    }
    
    func routeToSearchResults() {
        let destinationVC = SearchResultsViewController().configureView() as! SearchResultsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSearchResults(source: dataStore!, destination: &destinationDS)
        navigateToSearchResults(source: viewController!, destination: destinationVC)
    }
    
  // MARK: Navigation
  
    func navigateToMediaSelection(source: SearchViewController, destination: SelectMediaTypesViewController) {
        destination.router!.delegate = self
        source.show(destination, sender: nil)
    }
  
    func navigateToSearchResults(source: SearchViewController, destination: SearchResultsViewController) {
        source.show(destination, sender: nil)
    }

  // MARK: Passing data
  
  func passDataToMediaSelection(source: SearchDataStore, destination: inout SelectMediaTypesDataStore) {
      destination.selectedMediaTypes = source.mediaTypes
  }
    
   func passDataToSearchResults(source: SearchDataStore, destination: inout SearchResultsDataStore) {
       destination.searchResults = source.searchData
   }
}
extension SearchRouter: SelectMediaTypeRouterData {
    func updateDataInPreviousViewRouter(dataStore: SelectMediaTypesDataStore) {
        self.dataStore?.mediaTypes = dataStore.selectedMediaTypes
    }
}

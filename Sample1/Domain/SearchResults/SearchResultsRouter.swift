//
//  SearchResultsRouter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
 

import UIKit

@objc protocol SearchResultsRoutingLogic {
    func routeToDetailPage(index: IndexPath, image: UIImage?)
}

protocol SearchResultsDataPassing {
  var dataStore: SearchResultsDataStore? { get }
}

class SearchResultsRouter: NSObject, SearchResultsRoutingLogic, SearchResultsDataPassing {
  weak var viewController: SearchResultsViewController?
  var dataStore: SearchResultsDataStore?
  
  // MARK: Routing
    func routeToDetailPage(index: IndexPath, image: UIImage?) {
        let destinationVC = DetailViewController().configureView() as! DetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailPage(index: index, image: image, source: dataStore!, destination: &destinationDS)
        navigateToDetailPage(source: viewController!, destination: destinationVC)
    }
    // MARK: Passing data
    
    func passDataToDetailPage(index: IndexPath, image: UIImage?, source: SearchResultsDataStore, destination: inout DetailDataStore) {
        if let searchResults = dataStore?.searchResults {
            let sectionModel = searchResults[index.section]
            let item = sectionModel.results[index.row]
            destination.image = image
            destination.data = item
        }
    }

    // MARK: Navigation

    func navigateToDetailPage(source: SearchResultsViewController, destination: DetailViewController) {
        source.show(destination, sender: nil)
    }
}

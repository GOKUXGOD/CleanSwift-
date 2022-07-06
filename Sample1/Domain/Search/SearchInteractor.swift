//
//  SearchInteractor.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

protocol SearchBusinessLogic{
    func getSearchData(request: Search.SearchItems.Request)
    func getMediaTypes(request: Search.GetMediaTypes.Request)
    func validateInputs(txtSearch: UITextField, txtMediaTypes: UITextView)
}

protocol SearchDataStore {
    var mediaTypes: MediaTypes? {get set}
    var searchData: [SearchData]? {get set}
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  var mediaTypes: MediaTypes?
  var presenter: SearchPresentationLogic?
  var networkWorker: SearchNetworkWorker?
  var validatorWorker: SearchValidateWorker?
  var searchData: [SearchData]?

  // MARK: Do SearchItems
  
    func getSearchData(request: Search.SearchItems.Request) {
        let searchClient = SearchAPIClient(configuration: .default)
        let searchWorkerService = SearchNetworkService(networkService: searchClient)
        networkWorker = SearchNetworkWorker(searchNetworkService: searchWorkerService)
        networkWorker?.fetchSearchData(request: request, completion: { [weak self] result in
            self?.searchData = result.searchResults
            self?.presenter?.presentWithSearchData(response: result)
        })
    }
    
    func getMediaTypes(request: Search.GetMediaTypes.Request) {
        if let mediaTypes = mediaTypes {
            presenter?.presentMediaTypes(response: Search.GetMediaTypes.Response(mediaTypesData: mediaTypes))
        }
    }

    func validateInputs(txtSearch: UITextField, txtMediaTypes: UITextView) {
        let worker = SearchValidateWorker()
        let output = worker.validate(txtSearch: txtSearch, txtMediaTypes: txtMediaTypes)
        if output.Passed == true {
            presenter?.informViewToHitApi()
        } else {
            presenter?.presentValidations(validations: output)
        }
    }
}

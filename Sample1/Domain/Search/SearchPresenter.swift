//
//  SearchPresenter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

enum SearchPresenterError: Error {
    case noData

    var localizedDescription: String {
        switch self {
        case .noData: return "No data found, please try something else"
        }
    }
}

protocol SearchPresentationLogic {
    func presentMediaTypes(response: Search.GetMediaTypes.Response)
    func presentValidations(validations: SearchValidateWorkerOutput)
    func informViewToHitApi()
    func presentWithSearchData(response: Search.SearchItems.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    func presentValidations(validations: SearchValidateWorkerOutput) {
        viewController?.displayValidatorError(message: validations.FailedMsg.rawValue)
    }
    
    func presentMediaTypes(response: Search.GetMediaTypes.Response) {
        let mediaTypes = response.mediaTypesData.medias
        let viewModel = Search.GetMediaTypes.ViewModel(mediaTypes: mediaTypes)
        viewController?.displayMediaTypes(viewModel: viewModel)
    }

    func informViewToHitApi() {
        viewController?.proceesToApiCall()
    }

    func presentWithSearchData(response: Search.SearchItems.Response) {
        var responseR = response
        if response.searchResults.isEmpty {
            if let _ = responseR.error {
                responseR.errorMsg = "Something wrong with network"
            }
            responseR.error = SearchPresenterError.noData
            responseR.errorMsg = "No Results found, please try something else"
        }
        viewController?.displaySearchData(response: responseR)
    }
}

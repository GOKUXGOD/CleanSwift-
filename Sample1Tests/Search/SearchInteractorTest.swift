//
//  SearchInteractorTest.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import XCTest
@testable import Sample1
class SearchInteractorTest: XCTestCase {
    var sut: SearchInteractor!
    var presenterSpy: CreateSearchPresnterSpy!
    
    override func setUp() {
      super.setUp()
      sut = SearchInteractor()
      presenterSpy = CreateSearchPresnterSpy()
    }
    
    override func tearDown() {
        sut = nil
        presenterSpy = nil
      super.tearDown()
    }

    // MARK: - Test doubles
    class CreateSearchPresnterSpy: SearchPresentationLogic {
        // MARK: Method call expectations
        var presentMediaTypesCalled = false
        var presentValidationsCalled = false
        var informViewToHitApiCalled = false
        var presentWithSearchDataCalled = false
    
        // MARK: Spied methods
        func presentMediaTypes(response: Search.GetMediaTypes.Response) {
            presentMediaTypesCalled = true
        }
        
        func presentValidations(validations: SearchValidateWorkerOutput) {
            presentValidationsCalled = true
        }
        
        func informViewToHitApi() {
            informViewToHitApiCalled = true
        }
        
        func presentWithSearchData(response: Search.SearchItems.Response) {
            presentWithSearchDataCalled = true
        }
    }
    
    class ValidateWorkerSpy: ValidateViewComponents {
        var validateCalled = false
    
        func validate(txtSearch: UITextField, txtMediaTypes: UITextView) -> SearchValidateWorkerOutput {
            validateCalled = true
            return (true, SearchValidateWorkerError.none)
        }
    }
    
    class SearchNetworkWorkerSpy: SearchNetworkingWorker {
        var fetchSearchDataCalled = false
        func fetchSearchData(request: Search.SearchItems.Request,
                             completion: @escaping (Search.SearchItems.Response) -> (Void)) {
            fetchSearchDataCalled = true
            let mockedData = Seeds.searchData
            let response = Search.SearchItems.Response(searchResults: [mockedData])
            completion(response)
        }
    }
    
    class SearchNetworkServiceSpy: SearchApiServiceProtocol {
        var searchNetworkServiceCalled = false
        func fetchSearchResult(endpoint: SearchEndpoint,
                               success: ((SearchData) -> Void)?,
                               failure: ((APIError) -> Void)?) {
            searchNetworkServiceCalled = true
        }
    }
}

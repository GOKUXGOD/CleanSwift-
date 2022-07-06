//
//  SearchViewTest.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import XCTest
@testable import Sample1
class SearchViewTest: XCTestCase {
    var sut: SearchViewController!
    var interactorSpy: CreateSearchInteractorSpy!
    var window: UIWindow!
    // MARK: - Test doubles
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setUpSearchViewController()
    }

    override func tearDown() {
        window = nil
        sut = nil
        interactorSpy = nil
        super.tearDown()
        
    }
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    // MARK: - Test doubles
    class CreateSearchInteractorSpy: SearchBusinessLogic {
        // MARK: Method call expectations
        var getSearchDataCalled = false
        var getMediatypesCalled = false
        var validateInputCalled = false
        
        // MARK: Spied methods
        func getSearchData(request: Search.SearchItems.Request) {
            getSearchDataCalled = true
        }
        
        func getMediaTypes(request: Search.GetMediaTypes.Request) {
            getMediatypesCalled = true
        }
        
        func validateInputs(txtSearch: UITextField, txtMediaTypes: UITextView) {
            validateInputCalled = true
        }
    }
    
    func setUpSearchViewController() {
        sut = SearchViewController().configureView()
    }
    
    func testGetMediaTypesCalledOnViewDidAppear() {
        //Given
        let interactorSpy = CreateSearchInteractorSpy()
        sut.interactor = interactorSpy
        loadView()
        //when
        sut.viewWillAppear(true)
        //then
        XCTAssert(interactorSpy.getMediatypesCalled, "Should fetch mediaTypes right after the view appears")
    }
    
    func testValidateInputsOnTappingSumbit() {
        //Given
        let interactorSpy = CreateSearchInteractorSpy()
        sut.interactor = interactorSpy
        loadView()
        //when
        sut.btnSubmitClicked(sut.btnSubmit)
        //then
        XCTAssert(interactorSpy.validateInputCalled, "Should validate inputs after submit buttonn taps")
    }
}

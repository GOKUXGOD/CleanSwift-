//
//  SelectMediaTypesPresenterTest.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 02/07/22.
//

import XCTest
@testable import Sample1
class SelectMediaTypesPresenterTest: XCTestCase {
    var sut: SelectMediaTypesPresenter!
    var viewSpy: SelectMediaTypesDisplayLogic!
    
    // MARK: - Test doubles
    class CreateViewControllerSpy: SelectMediaTypesDisplayLogic {
        var displayMediaTypesCalled = false
        func displayMediaTypes(viewModel: SelectMediaTypes.LoadMediaType.ViewModel) {
            displayMediaTypesCalled = true
        }
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SelectMediaTypesPresenter()
        viewSpy = CreateViewControllerSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        try super.tearDownWithError()
    }

    func testPresenterCallsViewToDisplayItems() {
        //Given
        sut.viewController = viewSpy
        //when
    
        //then
    }
}

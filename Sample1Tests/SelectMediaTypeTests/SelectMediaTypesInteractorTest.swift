//
//  SelectMediaTypesInteractorTest.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 02/07/22.
//

import XCTest
@testable import Sample1

class SelectMediaTypesInteractorTest: XCTestCase {
    var sut: SelectMediaTypesInteractor!
    var presenterSpy: CreateSelectMediaTypesPresenterSpy!
    
    // MARK: - Test doubles
    class CreateSelectMediaTypesPresenterSpy: SelectMediaTypesPresentationLogic {
        var mediaTypesData: MediaTypes?
        var presentMediaTypesCalled = false
    
        func presentMediaTypes(response: SelectMediaTypes.LoadMediaType.Response) {
            presentMediaTypesCalled = true
            mediaTypesData = response.mediaTypesData
        }
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SelectMediaTypesInteractor()
        presenterSpy = CreateSelectMediaTypesPresenterSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    func testInteractorCallsPresenterToPresentMediaTypes() {
      // Given
      sut.presenter = presenterSpy
        let mediaTypes = Seeds.mediaTypes
      // When
      let request = SelectMediaTypes.LoadMediaType.Request()
        sut.loadMediaTypes(request: request)
      // Then
        XCTAssertTrue(presenterSpy.presentMediaTypesCalled,
                      "loadIceCream(request:) should ask the presenter to present the same ice cream data it loaded")
        XCTAssertEqual(presenterSpy.mediaTypesData, mediaTypes)
    }
}

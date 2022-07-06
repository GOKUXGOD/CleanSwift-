//
//  SelectMediaTypesViewTest.swift
//  Sample1Tests
//
//  Created by Nitin Upadhyay on 02/07/22.
//

import XCTest
@testable import Sample1

class SelectMediaTypesViewTest: XCTestCase {
    var sut: SelectMediaTypesViewController!
    var interactorSpy: CreateSelectMediaTypesInteractorSpy!
    
    // MARK: - Test doubles
    
    class CreateSelectMediaTypesInteractorSpy: SelectMediaTypesBusinessLogic {
        func updateDataStoreWithSelectedMediaTypes(viewModel: [SelectMediaTypes.CheckListItem]) {
            
        }
        
        var loadMediaTypesCalled = false

        func loadMediaTypes(request: SelectMediaTypes.LoadMediaType.Request) {
            loadMediaTypesCalled = true
        }
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SelectMediaTypesViewController()
        interactorSpy = CreateSelectMediaTypesInteractorSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
        try super.tearDownWithError()
    }

    func testShouldLoadIceCreamOnViewAppear() {
      // Given
      sut.interactor = interactorSpy
      // When
      sut.fetchMediaTypes()
      // Then
      XCTAssertTrue(
        interactorSpy.loadMediaTypesCalled,
        "fetchIceCream() should ask the interactor to load the ice cream"
      )
    }
}

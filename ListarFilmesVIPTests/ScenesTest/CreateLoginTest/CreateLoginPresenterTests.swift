//
//  CreateLoginPresenterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class CreateLoginPresenterTests: XCTestCase {
    
    var sut: CreateLoginPresenter!
    var viewController: CreateLoginViewControllerSpy!
    
    override func setUp() {
        super.setUp()
        viewController = CreateLoginViewControllerSpy()
        sut = CreateLoginPresenter(viewController: viewController)
    }
    
    override func tearDown() {
        viewController = nil
        sut = nil
        super.tearDown()
    }
    
    func testPresentStartLoading() {
        // Given
        let response = CreateLoginModel.CreateLogin.Response()
        
        // When
        sut.presentStartLoading(response)
        
        // Then
        XCTAssertTrue(viewController.displayStartLoadingCalled)
    }
    
    func testPresentStopLoading() {
        // Given
        let response = CreateLoginModel.CreateLogin.Response()
        
        // When
        sut.presentStopLoading(response)
        
        // Then
        XCTAssertTrue(viewController.displayStopLoadingCalled)
    }
    
    func testPresentShowAlert() {
        // Given
        let response = CreateLoginModel.CreateLogin.Response(titleMessage: "Title", message: "Message")
        
        // When
        sut.presentShowAlert(response)
        
        // Then
        XCTAssertTrue(viewController.displayShowAlertCalled)
        XCTAssertEqual(viewController.viewModel?.titleMessage, response.titleMessage)
        XCTAssertEqual(viewController.viewModel?.message, response.message)
    }
}

class CreateLoginViewControllerSpy: UIViewController, CreateLoginDisplayLogic {
    
    var displayStartLoadingCalled = false
    var displayStopLoadingCalled = false
    var displayShowAlertCalled = false
    var viewModel: CreateLoginModel.CreateLogin.ViewModel?
    
    func displayStartLoading(_ viewModel: CreateLoginModel.CreateLogin.ViewModel) {
        displayStartLoadingCalled = true
    }
    
    func displayStopLoading(_ viewModel: CreateLoginModel.CreateLogin.ViewModel) {
        displayStopLoadingCalled = true
    }
    
    func displayShowAlert(_ viewModel: CreateLoginModel.CreateLogin.ViewModel) {
        displayShowAlertCalled = true
        self.viewModel = viewModel
    }
}


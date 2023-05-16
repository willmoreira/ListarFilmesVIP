//
//  ResetLoginPresenterTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 10/05/23.
//

import XCTest
@testable import ListarFilmesVIP

final class ResetLoginPresenterTests: XCTestCase {
    
    var sut: ResetLoginPresenter!
    var vcSpy: ResetLoginViewControllerSpy!
    
    override func setUp() {
        vcSpy = ResetLoginViewControllerSpy()
        sut = ResetLoginPresenter(viewController: vcSpy)
    }
    
    override func tearDown() {
        vcSpy = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testPresentStartLoading() {
        // Given
        let response = ResetLoginModel.ResetLogin.Response()
        
        // When
        sut.presentStartLoading(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayStartLoadingCalled)
    }
    
    func testPresentStopLoading() {
        // Given
        let response = ResetLoginModel.ResetLogin.Response()
        
        // When
        sut.presentStopLoading(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayStopLoadingCalled)
    }
    
    func testPresentShowAlert() {
        // Given
        let response = ResetLoginModel.ResetLogin.Response(titleMessage: "Title",   message: "Message")
        
        // When
        sut.presentShowAlert(response)
        
        // Then
        XCTAssertTrue(vcSpy.displayShowAlertCalled)
        XCTAssertEqual(vcSpy.viewmodel?.titleMessage, response.titleMessage)
        XCTAssertEqual(vcSpy.viewmodel?.message, response.message)

    }
}

class ResetLoginViewControllerSpy: UIViewController, ResetLoginDisplayLogic {
    
    var displayStartLoadingCalled = false
    var displayStopLoadingCalled = false
    var displayShowAlertCalled = false
    var viewmodel: ResetLoginModel.ResetLogin.ViewModel?
    
    func displayStartLoading(_ viewModel: ListarFilmesVIP.ResetLoginModel.ResetLogin.Response) {
        displayStartLoadingCalled = true
    }
    
    func displayStopLoading(_ viewModel: ListarFilmesVIP.ResetLoginModel.ResetLogin.Response) {
        displayStopLoadingCalled = true
    }
    
    func displayShowAlert(_ viewModel: ListarFilmesVIP.ResetLoginModel.ResetLogin.ViewModel) {
        displayShowAlertCalled = true
        self.viewmodel = viewModel
    }
}



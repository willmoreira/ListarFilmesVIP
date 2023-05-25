//
//  LoginWorkerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 23/05/23.
//

import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth

class LoginWorkerTests: XCTestCase {
    
    var worker: LoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        worker = LoginWorkerMock()
    }
    
    override func tearDown() {
        worker = nil
        super.tearDown()
    }
    
    func testSignInWithValidCredentialsReturnsAuthDataResult() {
        // Given
        let worker = LoginWorker()
        let expectation = XCTestExpectation(description: "Sign in expectation")
        var authResult: AuthDataResult?
        var authError: Error?
        
        // When
        worker.signIn(withEmail: TestStrings.existingRealEmail, password: TestStrings.existingPassword) { result, error in
            authResult = result
            authError = error
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(authResult)
        XCTAssertNil(authError)
    }
    
    func testSignInWithInvalidEmailReturnsErrorUserNotFound() {
        
        // Given
        let expectation = XCTestExpectation(description: "Sign in expectation")
        let worker = LoginWorker()
        let invalidEmail = TestStrings.newEmail
        let password = TestStrings.anyPassword

        // When
        worker.signIn(withEmail: invalidEmail, password: password) { (result, error) in
            
            // Then
            XCTAssertNil(result)
            XCTAssertEqual((error as NSError?)?.code, AuthErrorCode.userNotFound.rawValue)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

class LoginWorkerMock: LoginWorkerProtocol {
    var singInCompletion: ((String, String,((AuthDataResult?, Error?) -> Void)?) -> Void)?
    func signIn(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        singInCompletion?(withEmail, password, completion)
    }
}

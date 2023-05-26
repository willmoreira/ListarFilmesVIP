//
//  CreateLoginWorkerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 23/05/23.
//

import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth


final class CreateLoginWorkerTests: XCTestCase {
    
    var worker: CreateLoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        worker = CreateLoginWorkerMock()
    }
    
    override func tearDown() {
        worker = nil
        super.tearDown()
    }
    
    func testCreateUserSuccess() {
        // Given
        let worker = CreateLoginWorker()
        let expectation = XCTestExpectation(description: "Create user in expectation")
        var authResult: AuthDataResult?
        var authError: Error?
        
        // When
        //Quando rodar os testes mudar o email, pois se o email existir vai dar erro
        worker.createUser(withEmail: "q123456789013@gmail.com", password: TestStrings.anyPassword) { result, error in
            authResult = result
            authError = error
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(authResult)
        XCTAssertNil(authError)
    }
    
    func testCreateUserErrorUserExists() {
        // Given
        let expectation = XCTestExpectation(description: "Sign in expectation")
        let worker = CreateLoginWorker()
        let invalidEmail = TestStrings.existingRealEmail
        let password = TestStrings.anyPassword

        // When
        worker.createUser(withEmail: invalidEmail, password: password) { (result, error) in
            
            //Then
            XCTAssertNil(result)
            XCTAssertEqual((error as NSError?)?.code, AuthErrorCode.emailAlreadyInUse.rawValue)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

class CreateLoginWorkerMock: CreateLoginWorkerProtocol {
    var createUserCompletion: ((String, String,((AuthDataResult?, Error?) -> Void)?) -> Void)?
    func createUser(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        createUserCompletion?(withEmail, password, completion)
    }
}

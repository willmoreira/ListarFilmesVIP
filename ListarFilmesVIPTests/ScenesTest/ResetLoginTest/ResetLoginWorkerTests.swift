//
//  ResetLoginWorkerTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 23/05/23.
//

import XCTest
@testable import ListarFilmesVIP
import FirebaseAuth

final class ResetLoginWorkerTests: XCTestCase {

    var worker: ResetLoginWorkerMock!
    
    override func setUp() {
        super.setUp()
        worker = ResetLoginWorkerMock()
    }
    
    override func tearDown() {
        worker = nil
        
        super.tearDown()
    }
    
    func testResetWithValidCredentials() {
        //Given
        let worker = ResetLoginWorker()
        let expectation = XCTestExpectation(description: "Reset in expectation")
        var authError: Error?
        
        //When
        worker.resetUser(withEmail: "q@gmail.com") { error in
            authError = error
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(authError)
    }
    
    func testResetWithValidCredentialsErrorNotFoundLogin() {
        //Given
        let worker = ResetLoginWorker()
        let expectation = XCTestExpectation(description: "Reset in expectation error not found Login")
        var authError: Error?
        
        //When
        worker.resetUser(withEmail: "qwert@gmail.com") { error in
            XCTAssertEqual((error as NSError?)?.code, AuthErrorCode.userNotFound.rawValue)
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(authError)
    }
}

class ResetLoginWorkerMock: ResetLoginWorkerProtocol {
    
    var resetUserCompletion: ((String,((Error?) -> Void)?) -> Void)?
    func resetUser(withEmail: String, completion: ((Error?) -> Void)?) {
        resetUserCompletion?(withEmail, completion)
    }
}

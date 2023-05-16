//
//  LoginWorker.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 16/05/23.
//

import Foundation
import FirebaseAuth

protocol LoginWorkerProtocol {
    func signIn(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}

class LoginWorker: LoginWorkerProtocol {
    func signIn(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: withEmail, password: password) {
            result, error in
            completion?(result, error)
        }
    }
}

//
//  CreateLoginWorker.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 15/05/23.
//

import Foundation
import FirebaseAuth

protocol CreateLoginWorkerProtocol {
    func createUser(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}

class CreateLoginWorker: CreateLoginWorkerProtocol {
    func createUser(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { result, error in
            completion?(result, error)
        }
    }
}

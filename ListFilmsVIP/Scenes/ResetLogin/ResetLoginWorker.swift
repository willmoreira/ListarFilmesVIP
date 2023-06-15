//
//  ResetLoginWorker.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 16/05/23.
//

import Foundation
import FirebaseAuth

protocol ResetLoginWorkerProtocol {
    func resetUser(withEmail: String, completion: ((Error?) -> Void)?)
}

class ResetLoginWorker: ResetLoginWorkerProtocol {
    func resetUser(withEmail: String, completion: ((Error?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: withEmail) { error in
            completion?(error)
        }
    }
}

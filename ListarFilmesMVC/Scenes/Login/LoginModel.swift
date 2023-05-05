//
//  LoginModel.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 02/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//


import Foundation

enum LoginModel {
    
    enum Route {
        case dismissLoginScene
        case xScene(xData: Int)
    }
    
    struct DataSource {
        //var test: Int
    }
    
    enum Login {
        struct Request {
            var password: String?
            var login: String?
        }
        
        struct Response {
            var titleMessage: String?
            var message: String?
        }
        
        struct ViewModel {
            var titleMessage: String?
            var message: String?
        }
        
        struct Route {
            
        }
    }
}

//
//  SceneDelegate.swift
//  ListarFilmesMVC
//
//  Created by William Moreira on 26/04/23.
//

import UIKit
import FirebaseCore

      
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        let mainView = LoginView()
        let filmList = FilmModel(page: 0,
                                 results: [Result(adult: false,
                                                  backdropPath: "",
                                                  genreIDS: [0],
                                                  id: 0,
                                                  originalLanguage: .en,
                                                  originalTitle: "",
                                                  overview: "",
                                                  popularity: 0.0,
                                                  posterPath: "",
                                                  releaseDate: "",
                                                  title: "",
                                                  video: false,
                                                  voteAverage: 0.0,
                                                  voteCount: 0)],
                                 totalPages: 0,
                                 totalResults: 0)
        let dataSource = LoginModel.DataSource(filmModelList: filmList)
        
        let viewController = LoginViewController(mainView: mainView, dataSource: dataSource)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


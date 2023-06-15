//
//  BaseUIViewController.swift
//  ListarFilmesVIP
//
//  Created by William Moreira on 19/05/23.
//

import UIKit

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(ProjectStrings.fatalError.localized)
    }
}

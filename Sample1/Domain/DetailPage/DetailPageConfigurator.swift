//
//  DetailPageConfigurator.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
//

import UIKit
extension DetailViewController {
    func configureView() -> UIViewController {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    
        return viewController
    }
}

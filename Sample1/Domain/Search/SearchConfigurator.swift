//
//  SearchConfigurator.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import Foundation
import UIKit

extension SearchViewController {
    func configureView() -> SearchViewController {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}

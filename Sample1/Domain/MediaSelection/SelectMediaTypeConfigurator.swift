//
//  SelectMediaTypeConfigurator.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 02/07/22.
//

import Foundation
import UIKit

extension SelectMediaTypesViewController {
    func configureView() -> UIViewController {
        let viewController = self
        let interactor = SelectMediaTypesInteractor()
        let presenter = SelectMediaTypesPresenter()
        let router = SelectMediaTypesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}

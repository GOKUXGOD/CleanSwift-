//
//  AppRouter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 30/06/22.
//

import Foundation
import UIKit

final class AppRouter {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController().configureView()
        navigationController.pushViewController(searchViewController, animated: false)
    }
}

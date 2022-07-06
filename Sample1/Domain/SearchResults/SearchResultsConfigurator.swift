//
//  SearchResultsConfigurator.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import Foundation
import UIKit

extension SearchResultsViewController {
    func configureView() -> UIViewController {
        let viewController = self
        let interactor = SearchResultsInteractor()
        let presenter = SearchResultsPresenter()
        let router = SearchResultsRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.layoutInfo = SearchResultsLayoutInfo(numberOfItemsInRow: 3, minimumSpacing: 5, edgeInsetPadding: 10, edgeInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), cellIdentifier: "SearchResultsCell", listCellIndetifier: "SearchResultListcell", headerIdentifier: "SectionHeader")
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
    
    func imageFetcher() -> ImageFetcher {
        let client = SearchImageClient(configuration: .default)
        return DefaultImageFetcher(imageClient: client)
    }
}

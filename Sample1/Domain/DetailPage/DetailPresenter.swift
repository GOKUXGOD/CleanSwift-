//
//  DetailPresenter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
 

import UIKit

protocol DetailPresentationLogic {
  func presentDetailPageData(response: Detail.RailDetails.Response)
}

class DetailPresenter: DetailPresentationLogic {
  weak var viewController: DetailDisplayLogic?
  
  // MARK: Do something
  
    func presentDetailPageData(response: Detail.RailDetails.Response) {
        let viewModel = Detail.RailDetails.ViewModel(item: response.data, image: response.image)
        viewController?.displayDetailPageData(viewModel: viewModel)
    }
}

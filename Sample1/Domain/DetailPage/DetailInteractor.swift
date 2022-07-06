//
//  DetailInteractor.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
 

import UIKit

protocol DetailBusinessLogic {
  func fetchDetailPageData(request: Detail.RailDetails.Request)
}

protocol DetailDataStore {
  var data: Item? { get set }
  var image: UIImage? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
  var presenter: DetailPresentationLogic?
  var data: Item?
  var image: UIImage?
  
  // MARK: Do something
  
  func fetchDetailPageData(request: Detail.RailDetails.Request) {
      if let data = data, let image = image {
          let response = Detail.RailDetails.Response(data: data, image: image)
          presenter?.presentDetailPageData(response: response)
      }
  }
}

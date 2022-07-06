//
//  DetailRouter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
 

import UIKit

@objc protocol DetailRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailDataPassing {
  var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing {
  weak var viewController: DetailViewController?
  var dataStore: DetailDataStore?
}

//
//  SelectMediaTypesRouter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import Foundation
import UIKit

@objc protocol SelectMediaTypesRoutingLogic {
    
}

protocol SelectMediaTypeRouterData: AnyObject {
    func updateDataInPreviousViewRouter(dataStore: SelectMediaTypesDataStore)
}

protocol SelectMediaTypesDataPassing {
    var dataStore: SelectMediaTypesDataStore? { get }
    var delegate: SelectMediaTypeRouterData? { get set}
}

class SelectMediaTypesRouter: NSObject, SelectMediaTypesRoutingLogic, SelectMediaTypesDataPassing {
    var delegate: SelectMediaTypeRouterData?
    
    weak var viewController: SelectMediaTypesViewController?
    var dataStore: SelectMediaTypesDataStore?
}

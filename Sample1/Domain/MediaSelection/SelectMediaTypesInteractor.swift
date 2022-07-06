//
//  SelectMediaTypesInteractor.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

protocol SelectMediaTypesBusinessLogic {
    func loadMediaTypes(request: SelectMediaTypes.LoadMediaType.Request)
    func updateDataStoreWithSelectedMediaTypes(viewModel: [SelectMediaTypes.CheckListItem])
}

protocol SelectMediaTypesDataStore {
    var selectedMediaTypes: MediaTypes? {get set}
}
class SelectMediaTypesInteractor: SelectMediaTypesBusinessLogic, SelectMediaTypesDataStore {
  var selectedMediaTypes: MediaTypes?
  var presenter: SelectMediaTypesPresentationLogic?
    
  // MARK: Do LoadMediaType
    func loadMediaTypes(request: SelectMediaTypes.LoadMediaType.Request) {
        let mediaTypes = Bundle.main.decode(MediaTypes.self, from: "MediaTypes.json")
        let response = SelectMediaTypes.LoadMediaType.Response(mediaTypesData: mediaTypes, selectedMediaTypes: selectedMediaTypes)
        presenter?.presentMediaTypes(response: response)
    }

    func updateDataStoreWithSelectedMediaTypes(viewModel: [SelectMediaTypes.CheckListItem]) {
        let selectedItems = viewModel.filter({$0.isChecked == true}).map({String($0.name)})
        selectedMediaTypes = MediaTypes(medias: selectedItems)
    }
}


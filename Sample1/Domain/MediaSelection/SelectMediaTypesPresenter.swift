//
//  SelectMediaTypesPresenter.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

protocol SelectMediaTypesPresentationLogic {
  func presentMediaTypes(response: SelectMediaTypes.LoadMediaType.Response)
}

class SelectMediaTypesPresenter: SelectMediaTypesPresentationLogic {
  weak var viewController: SelectMediaTypesDisplayLogic?
  
  // MARK: Do LoadMediaType
  
  func presentMediaTypes(response: SelectMediaTypes.LoadMediaType.Response) {
      let checkListItem = createCheckListItem(response.mediaTypesData)
      if let selectedMedias = response.selectedMediaTypes?.medias {
          for selectedMedia in selectedMedias {
              if let index = checkListItem.firstIndex(where: {$0.name == selectedMedia}) {
                  checkListItem[index].isChecked = true
              }
          }
      }
      let viewModel = SelectMediaTypes.LoadMediaType.ViewModel(mediaTypes: checkListItem)
      viewController?.displayMediaTypes(viewModel: viewModel)
  }
}

extension SelectMediaTypesPresenter {
    func createCheckListItem(_ mediatypes: MediaTypes) -> [SelectMediaTypes.CheckListItem] {
        let checkListItem = mediatypes.medias.map { name in
            SelectMediaTypes.CheckListItem(name: name, isChecked: false)
        }
        return checkListItem
    }
}

//
//  SelectMediaTypesModels.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit
protocol CheckListable {
    var name: String {get}
    var isChecked: Bool {get set}
}

enum SelectMediaTypes
{
    class CheckListItem: CheckListable {
        var name: String
        var isChecked: Bool

        init(name: String, isChecked: Bool) {
            self.name = name
            self.isChecked = isChecked
        }
    }

    enum LoadMediaType {
        struct Request{}
        struct Response {
            var mediaTypesData: MediaTypes
            var selectedMediaTypes: MediaTypes?
        }
        class ViewModel {
            var mediaTypes: [CheckListItem]
            init(mediaTypes: [CheckListItem]) {
                self.mediaTypes = mediaTypes
            }
        }
    }
}

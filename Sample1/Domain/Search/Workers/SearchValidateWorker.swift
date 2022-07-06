//
//  SearchValidateWorker.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
//

import UIKit
enum SearchValidateWorkerError: String {
    case optionalError = "Not able to get the textFields"
    case searchKeyWordEmpty = "Please enter some text to search"
    case searchMediaTypesEmpty = "Please select a media category"
    case none = ""
}
typealias SearchValidateWorkerOutput = (Passed: Bool, FailedMsg: SearchValidateWorkerError)

protocol ValidateViewComponents {
    func validate(txtSearch: UITextField, txtMediaTypes: UITextView) -> SearchValidateWorkerOutput
}

class SearchValidateWorker: ValidateViewComponents {
    func validate(txtSearch: UITextField, txtMediaTypes: UITextView) -> SearchValidateWorkerOutput {
        guard let searchText = txtSearch.text, let mediaTypes = txtMediaTypes.text else {
            return (false, SearchValidateWorkerError.optionalError)
        }
        guard !searchText.isEmpty else {
            return (false, SearchValidateWorkerError.searchKeyWordEmpty)
        }
        guard !mediaTypes.isEmpty else {
            return (false, SearchValidateWorkerError.searchMediaTypesEmpty)
        }
        return (true, SearchValidateWorkerError.none)
    }
}

//
//  SearchViewModel.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 30/06/22.
//

import Foundation
protocol SearchInput {
    var didTapSubmit: ((String) -> ())? { get }
    var didTapSelectMediaTypes: (() -> ())? { get }
}

protocol SearchOutput {
    
}

protocol SearchVM: SearchInput, SearchOutput {}

final class SearchViewModel: SearchVM {
    var didTapSubmit: ((String) -> ())?
    var didTapSelectMediaTypes: (() -> ())?
    
    init(didTapSubmit: ((String) -> ())?,
         didTapSelectMediaTypes: (() -> ())?) {
        self.didTapSubmit = didTapSubmit
        self.didTapSelectMediaTypes = didTapSelectMediaTypes
    }
}

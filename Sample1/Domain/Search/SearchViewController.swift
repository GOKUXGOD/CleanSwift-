//
//  SearchViewController.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

protocol SearchDisplayLogic: AnyObject {
  func displayMediaTypes(viewModel: Search.GetMediaTypes.ViewModel)
  func displayValidatorError(message: String)
  func proceesToApiCall()
  func displaySearchData(response: Search.SearchItems.Response)
}

class SearchViewController: UIViewController, SearchDisplayLogic, Alertable {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtMediaTypes: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
  
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    private var viewModel: Search.GetMediaTypes.ViewModel!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
    private func setUI() {
        btnSubmit.layer.cornerRadius = 5.0
        txtMediaTypes.layer.cornerRadius = 5.0
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        interactor?.validateInputs(txtSearch: txtSearch, txtMediaTypes: txtMediaTypes)
    }
    
    @IBAction func btnSelectTypesClicked(_ sender: UIButton) {
        router?.routeToMediaSelection()
    }

  // MARK: View lifecycle
  
  override func viewDidLoad() {
      super.viewDidLoad()

      title = "Search"
      setUI()
      getMediaTypes()
  }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getMediaTypes()
    }

  // MARK: Do SearchItems
  
  func getSearchResuls() {
      let request = Search.SearchItems.Request(mediaTypes: viewModel.mediaTypes, searchTerm: txtSearch.text!)
      interactor?.getSearchData(request: request)
  }
    
    func getMediaTypes() {
        let request = Search.GetMediaTypes.Request()
        interactor?.getMediaTypes(request: request)
    }

  //MARK: Presenter
  func displayMediaTypes(viewModel: Search.GetMediaTypes.ViewModel) {
      self.viewModel = viewModel
      let medias = viewModel.mediaTypes.joined(separator: " ")
      let attributedString = NSMutableAttributedString(string: medias)
      var startIndex = medias.startIndex
      while let range = medias.range(of: "\\S+", options: .regularExpression, range: startIndex..<medias.endIndex) {
          attributedString.addAttribute(.backgroundColor, value: UIColor.systemOrange, range: NSRange(range, in: medias))
          attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .semibold), range: NSRange(range, in: medias))
          startIndex = range.upperBound
      }
      txtMediaTypes.attributedText = attributedString
  }
    
    func displayValidatorError(message: String) {
        show(message: message)
    }
    
    func proceesToApiCall() {
        indicator.startAnimating()
        let request = Search.SearchItems.Request(mediaTypes: viewModel.mediaTypes, searchTerm: txtSearch.text!)
        interactor?.getSearchData(request: request)
    }
    
    func displaySearchData(response: Search.SearchItems.Response) {
        indicator.stopAnimating()

        if let errorMsg = response.errorMsg {
            show(message: errorMsg)
        }
        else {
            router?.routeToSearchResults()
        }
    }
}

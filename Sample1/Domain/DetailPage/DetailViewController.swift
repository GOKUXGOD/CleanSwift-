//
//  DetailViewController.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 04/07/22.
 

import UIKit
import AVKit

protocol DetailDisplayLogic: AnyObject {
    func displayDetailPageData(viewModel: Detail.RailDetails.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic, Alertable {
  var interactor: DetailBusinessLogic?
  var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
  var previewUrl: URL?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonToPlay: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var playerContainerView: UIView!
    
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailPageDataFromInteractor()
    }
  
    @IBAction func buttonToPlayClicked(_ sender: Any) {
        if let videoUrl = previewUrl {
            let player = AVPlayer(url: videoUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        } else {
            show(message: "No preview available")
        }
    }

  // MARK: Do something
  
  func getDetailPageDataFromInteractor() {
    let request = Detail.RailDetails.Request()
    interactor?.fetchDetailPageData(request: request)
  }
  
  func displayDetailPageData(viewModel: Detail.RailDetails.ViewModel) {
      title = viewModel.title
      labelType.text! += viewModel.type
      labelTitle.text! += viewModel.title
      labelArtist.text! += viewModel.artistName
      labelCountry.text! += viewModel.country
      imageView.image = viewModel.image
      if let urlString = viewModel.previewUrl, let url = URL(string: urlString) {
          previewUrl = url
      }
  }
}

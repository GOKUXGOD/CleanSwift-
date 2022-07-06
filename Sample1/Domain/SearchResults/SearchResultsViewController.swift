//
//  SearchResultsViewController.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 03/07/22.
 

import UIKit
enum Mode {
    case list
    case grid
}

protocol SearchResultsDisplayLogic: AnyObject {
  func displaySearchResults(viewModel: SearchResults.SearchItems.ViewModel)
}

class SearchResultsViewController: UIViewController, SearchResultsDisplayLogic {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnToGridView: UIButton!
    
    @IBOutlet weak var btnToListView: UIButton!
    
    var interactor: SearchResultsBusinessLogic?
    var router: (NSObjectProtocol & SearchResultsRoutingLogic & SearchResultsDataPassing)?
    private var viewModel: SearchResults.SearchItems.ViewModel?
    var layoutInfo: SearchResultsLayoutInfo!

    private var mode = Mode.grid {
        didSet {
            reloadLayout()
        }
    }
    
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
        
        title = "Search Results"
        setUpCollectionView()
        interactor?.getSearchResults(request: SearchResults.SearchItems.Request())
        setUpInitialButtonState()
    }
    
    private func setUpCollectionView() {
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: layoutInfo.cellIdentifier)
        collectionView.register(SearchResultListcell.self, forCellWithReuseIdentifier: layoutInfo.listCellIndetifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: layoutInfo.headerIdentifier)
    }
  
  // MARK: Presenter Output
  
    func displaySearchResults(viewModel: SearchResults.SearchItems.ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    private func setUpInitialButtonState() {
        handleSelection(selected: btnToGridView, deselect: btnToListView)
    }
    
    @IBAction func btnToListTapped(_ sender: UIButton) {
        if mode == .list {
            return
        }
        mode = .list
        handleSelection(selected: sender, deselect: btnToGridView)
    }
    
    @IBAction func btnToGridTapped(_ sender: UIButton) {
        if mode == .grid {
            return
        }
        mode = .grid
        handleSelection(selected: sender, deselect: btnToListView)
    }
    
    private func handleSelection(selected: UIButton, deselect: UIButton) {
        deselect.backgroundColor = .lightGray
        deselect.isSelected = false
        
        selected.backgroundColor = .darkGray
        selected.isSelected = true
    }
    
    private func reloadLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
}

extension SearchResultsViewController: UICollectionViewDelegate {
    
}
extension SearchResultsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.railItems.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.railItems[section].railItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let railSection = viewModel.railItems[indexPath.section]
        let railItem = railSection.railItems[indexPath.row]
        var identifier = ""
        switch mode {
        case .list:
            identifier = layoutInfo.listCellIndetifier
        case .grid:
            identifier = layoutInfo.cellIdentifier
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseCollectionViewCell
        cell.updateWith(viewModel: railItem, imageFetcher: SearchResultsViewController().imageFetcher())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        sectionHeader.label.text = viewModel.railItems[indexPath.section].type.rawValue
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        let sectionModel = viewModel.railItems[indexPath.section]
        let item = sectionModel.railItems[indexPath.row]
        router?.routeToDetailPage(index: indexPath, image: item.image)
    }
    
}
extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = layoutInfo.edgeInsets
        layoutInfo.edgeInsetPadding = inset.left+inset.right
        return inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutInfo.minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutInfo.minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch mode {
        case .grid:
            let width = (collectionView.bounds.width - CGFloat(layoutInfo.numberOfItemsInRow - 1) * layoutInfo.minimumSpacing - layoutInfo.edgeInsetPadding) / CGFloat(layoutInfo.numberOfItemsInRow)

            return CGSize(width: width, height: 150)
        case .list:
            let width = collectionView.bounds.width - (layoutInfo.minimumSpacing + layoutInfo.edgeInsetPadding)
            return CGSize(width: width, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

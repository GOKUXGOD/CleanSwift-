//
//  SelectMediaTypesViewController.swift
//  Sample1
//
//  Created by Nitin Upadhyay on 01/07/22.
 

import UIKit

protocol SelectMediaTypesDisplayLogic: AnyObject {
  func displayMediaTypes(viewModel: SelectMediaTypes.LoadMediaType.ViewModel)
}

class SelectMediaTypesViewController: UIViewController, SelectMediaTypesDisplayLogic {
    var interactor: SelectMediaTypesBusinessLogic?
    var router: (NSObjectProtocol & SelectMediaTypesRoutingLogic & SelectMediaTypesDataPassing)?

    private var tableView: UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
    
       return tableView
    }()
    
    private var mediaTypes: [SelectMediaTypes.CheckListItem]! {
        didSet {
            tableView.reloadData()
        }
    }
    private var cellIdentifier = "SelectMediaTypesCell"
    

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

        setUpView()
        fetchMediaTypes()
        title = "Select Media Types"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let navController = navigationController, navController.viewControllers.firstIndex(of: self) == nil {
            interactor?.updateDataStoreWithSelectedMediaTypes(viewModel: mediaTypes)
            router?.delegate?.updateDataInPreviousViewRouter(dataStore: router!.dataStore!)
        }
        super.viewWillDisappear(animated)
    }
  
    private func setUpView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SelectMediaTypesCell.self, forCellReuseIdentifier: cellIdentifier)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(tableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        NSLayoutConstraint.activate(constraints)
    }

  // MARK: Do LoadMediaType
  
  func fetchMediaTypes() {
      let request = SelectMediaTypes.LoadMediaType.Request()
      interactor?.loadMediaTypes(request: request)
  }
  
  func displayMediaTypes(viewModel: SelectMediaTypes.LoadMediaType.ViewModel) {
      mediaTypes = viewModel.mediaTypes
  }
    
    deinit {
        print("Select media type vC deinit")
    }
}

extension SelectMediaTypesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaTypes.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = mediaTypes[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            let model = mediaTypes[indexPath.row]
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                model.isChecked = false
            }
            else {
                cell.accessoryType = .checkmark
                model.isChecked = true
            }
        }
    }
}


//
//  FilterViewController.swift
//  AppleMediaList
//
//  Created by Bali on 19/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

enum FilterSections: String {
  case MediaType = "Media Type"
  case FeedType = "Feed Type"
  case ResultsLimit = "Results limit"
  case AllowExplicit = "Allow explicit"
}

protocol FilterViewControllerDelegate: class {
  func didSavedFilterSettings()
}

class FilterViewController: UIViewController {
  
  let tableView = UITableView(frame: .zero, style: .grouped)
  let sections: [FilterSections] = [.MediaType, .FeedType, .ResultsLimit, .AllowExplicit]
  
  var mediaType = UserDataManager.shared.mediaType
  var feedType = UserDataManager.shared.feedType
  var resultsLimit = UserDataManager.shared.resultLimit
  var allowExplicit = UserDataManager.shared.allowExplicit
  
  weak var delegate: FilterViewControllerDelegate?
  
  // MARK: - Lifecycle
  override func loadView() {
    super.loadView()
    
    setupNavigationBar()
    setupTableView()
    registerTableViewCell()
  }
  
  // MARK: - Private Methods
  private func setupNavigationBar() {
    navigationItem.title = "Filter"
    
    let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
    navigationItem.leftBarButtonItem = leftBarButtonItem
    
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped(_:)))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc private func cancelButtonTapped(_ button: UIBarButtonItem) {
    if UserDataManager.shared.mediaType == mediaType && UserDataManager.shared.feedType == feedType && UserDataManager.shared.resultLimit == resultsLimit && UserDataManager.shared.allowExplicit == allowExplicit {
      navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Warning!", message: "You are about to lose data. Do you wish to continue?", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
        self.navigationController?.popViewController(animated: true)
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(okAction)
      alertController.addAction(cancelAction)
      present(alertController, animated: true, completion: nil)
    }
  }
  
  @objc private func saveButtonTapped(_ button: UIBarButtonItem) {
    UserDataManager.shared.mediaType = mediaType
    UserDataManager.shared.feedType = feedType
    UserDataManager.shared.resultLimit = resultsLimit
    UserDataManager.shared.allowExplicit = allowExplicit
    
    delegate?.didSavedFilterSettings()
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func registerTableViewCell() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwitchCellIdentifier")
  }
}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if sections[indexPath.section] == .AllowExplicit {
      let switchCell = tableView.dequeueReusableCell(withIdentifier: "SwitchCellIdentifier", for: indexPath)
      switchCell.textLabel?.text = sections[indexPath.section].rawValue
      let switchView = UISwitch()
      switchView.isOn = allowExplicit
      switchView.removeTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
      switchView.addTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
      switchCell.accessoryView = switchView
      return switchCell
    } else {
      var cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")
      if cell == nil {
        cell = UITableViewCell(style: .value1, reuseIdentifier: "CellIdentifier")
      }
      cell!.accessoryType = .disclosureIndicator
      cell!.textLabel?.text = sections[indexPath.section].rawValue
      
      switch sections[indexPath.section] {
      case .MediaType:
        cell!.detailTextLabel?.text = mediaType.rawValue
      case .FeedType:
        cell!.detailTextLabel?.text = feedType.rawValue
      case .ResultsLimit:
        cell!.detailTextLabel?.text = "\(resultsLimit)"
      default:
        break
      }
      
      return cell!
    }
  }
  
  @objc private func switchTapped(_ switchView: UISwitch) {
    allowExplicit = switchView.isOn
  }
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard sections[indexPath.section] != .AllowExplicit else { return }
    
    let actionViewController = UIAlertController(title: sections[indexPath.section].rawValue, message: nil, preferredStyle: .actionSheet)
    if sections[indexPath.section] == .MediaType {
      for mediaType in MediaType.AllMediaTypes {
        let action = UIAlertAction(title: mediaType.rawValue, style: .default) { (_) in
          self.mediaType = mediaType
          self.feedType = FeedType.FeedTypeInfo[mediaType]![0]
          self.tableView.reloadSections([indexPath.section, indexPath.section + 1], with: .automatic)
        }
        actionViewController.addAction(action)
      }
    } else if sections[indexPath.section] == .FeedType {
      for feedType in FeedType.FeedTypeInfo[mediaType]! {
        let action = UIAlertAction(title: feedType.rawValue, style: .default) { (_) in
          self.feedType = feedType
          self.tableView.reloadSections([indexPath.section], with: .automatic)
        }
        actionViewController.addAction(action)
      }
    } else if sections[indexPath.section] == .ResultsLimit {
      for page in UserDataManager.resultPagesCount {
        let action = UIAlertAction(title: "\(page)", style: .default) { (_) in
          self.resultsLimit = page
          self.tableView.reloadSections([indexPath.section], with: .automatic)
        }
        actionViewController.addAction(action)
      }
    }
    
    actionViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(actionViewController, animated: true, completion: nil)
  }
}

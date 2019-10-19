//
//  HomeViewController.swift
//  AppleMediaList
//
//  Created by Bali on 18/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  var feed = Feed(data: [:]) {
    didSet {
      navigationItem.title = feed.title
      tableView.reloadData()
    }
  }
  
  // MARK: - Lifecycle
  override func loadView() {
    super.loadView()
    
    setupNavigationBar()
    setupTableView()
    registerTableViewCell()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchData()
  }
  
  // MARK: - Private Methods
  private func setupNavigationBar() {
    navigationController?.navigationBar.barTintColor = UIColor.white
    navigationController?.navigationBar.isTranslucent = true
    
    let rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterButtonTapped(_:)))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc private func filterButtonTapped(_ button: UIBarButtonItem) {
    let filterViewController = FilterViewController()
    filterViewController.delegate = self
    navigationController?.pushViewController(filterViewController, animated: true)
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
    tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.CellIdentifier)
  }
  
  private func fetchData() {
    ActivityIndicatorManager.shared.show()
    APIManager.fetchData { (result, error) in
      ActivityIndicatorManager.shared.dismiss()
      if let errorMessage = error {
        print(errorMessage)
        return
      }
      
      if let feed = result {
        self.feed = feed
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feed.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.CellIdentifier, for: indexPath) as! MediaTableViewCell

    cell.media = feed.items[indexPath.row]
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return MediaTableViewCell.CellHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let media = feed.items[indexPath.row]
    guard let url = URL(string: media.url) else { return }
    
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}

// MARK: - FilterViewControllerDelegate
extension HomeViewController: FilterViewControllerDelegate {
  func didSavedFilterSettings() {
    navigationController?.popViewController(animated: true)
    
    fetchData()
  }
}

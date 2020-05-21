//
//  ViewController.swift
//  HolidayCalendar
//
//  Created by Jonathan Go on 5/21/20.
//  Copyright © 2020 SonnerStudio. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

  private let mainTableVC = MainTableVC()
  let searchBar = UISearchBar()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupNavBar()
    searchBar.delegate = self
    
    setupMainTableVC()
  }


  private func setupNavBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Holiday Schedule"
    //navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
    //navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    navigationItem.scrollEdgeAppearance = appearance
    //navigationItem.standardAppearance = appearance
    //navigationItem.compactAppearance = appearance
    
    navigationController?.navigationBar.tintColor = .white
    showSearchBarButton(shouldShow: true)
    
    searchBar.sizeToFit()
  }
  
  
  private func setupMainTableVC() {
    add(mainTableVC)
    mainTableVC.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      mainTableVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainTableVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainTableVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mainTableVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  @objc func handleSearchBar() {
    search(shouldShow: true)
    searchBar.becomeFirstResponder()
  }
  
  
  func showSearchBarButton(shouldShow: Bool) {
    if shouldShow {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
    } else {
      navigationItem.rightBarButtonItem = nil
    }
  }
  
  func search(shouldShow: Bool) {
    showSearchBarButton(shouldShow: !shouldShow)
    searchBar.showsCancelButton = shouldShow
    navigationItem.titleView = shouldShow ? searchBar : nil
  }
}

extension MainVC: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    search(shouldShow: false)
  }
  
  
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchBarText = searchBar.text else { return }
    let request = RequestHandler(countryCode: searchBarText)
    request.getHolidays { [weak self] result in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let holidays):
        self?.mainTableVC.listOfHolidays = holidays
        //print(holidays)
      }
    }
  }
}

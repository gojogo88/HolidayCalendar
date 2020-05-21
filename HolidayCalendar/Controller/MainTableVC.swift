//
//  MainTableVC.swift
//  HolidayCalendar
//
//  Created by Jonathan Go on 5/21/20.
//  Copyright © 2020 SonnerStudio. All rights reserved.
//

import UIKit

class MainTableVC: UIViewController {
  
  lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.backgroundColor = .white
    tv.delegate = self
    tv.dataSource = self
    tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()
  
  var listOfHolidays = [HolidayDetail]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    
    
  }
  
  
  private func setupTableView() {
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
 
  }
}

extension MainTableVC: UITableViewDelegate {
  
}

extension MainTableVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listOfHolidays.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .white
    
    let holiday = listOfHolidays[indexPath.row]
    print("holiday is: \(holiday.name) on \(holiday.date.iso)")
    cell.textLabel?.text = holiday.name
    cell.detailTextLabel?.text = holiday.date.iso
    return cell
  }
}

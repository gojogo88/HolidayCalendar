//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by Jonathan Go on 5/21/20.
//  Copyright © 2020 SonnerStudio. All rights reserved.
//

import Foundation

struct HolidayResponse: Codable {
  var response: Holidays
}

struct Holidays: Codable {
  var holidays: [HolidayDetail]
}

struct HolidayDetail: Codable {
  var name: String
  var date: DateInfo
}

struct DateInfo: Codable {
  var iso: String
  
}


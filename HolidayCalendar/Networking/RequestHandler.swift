//
//  RequestHandler.swift
//  HolidayCalendar
//
//  Created by Jonathan Go on 5/21/20.
//  Copyright © 2020 SonnerStudio. All rights reserved.
//

import Foundation

enum HolidayError: Error {
  case noDataAvailable
  case cannotProcessData
}

struct RequestHandler {
  let resourceUrl: URL
  let API_KEY = "b052c3f7f0f217f5e41b8183fc65ccd9707c7f3b"
  
  init(countryCode: String) {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy"
    let currentYear = format.string(from: date)
    
    let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
   
    guard let resourceUrl = URL(string: resourceString) else { fatalError() }
    
    self.resourceUrl = resourceUrl
  }
  
  func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> ()) {
    let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.noDataAvailable))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
        let holidayDetails = holidaysResponse.response.holidays
        completion(.success(holidayDetails))
      } catch {
        completion(.failure(.cannotProcessData))
      }
    }
    dataTask.resume()
  }
}

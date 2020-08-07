//
//  DateUtils.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

struct DateUtils {
  static var currentDate: String {
    let date = Date()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: date)
  }
  
  static var nextYear: String {
    var dateComponents = DateComponents()
    dateComponents.year = 1
    
    let currentYear = Date()
    let nextYear = Calendar.current.date(byAdding: dateComponents, to: currentYear)!
    
    return nextYear.formatAsString
  }
  
  static var lastMonth: String {
    var dateComponents = DateComponents()
    dateComponents.month = -1
    
    let current = Date()
    let lastMonth = Calendar.current.date(byAdding: dateComponents, to: current);
    
    return lastMonth?.formatAsString ?? ""
  }
}


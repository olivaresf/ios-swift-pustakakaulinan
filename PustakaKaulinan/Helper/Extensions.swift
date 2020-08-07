//
//  Extensions.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation
import UIKit

extension Date {
  var formatAsString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: self)
  }
}

extension String {
  func convertHtml() -> NSAttributedString {
    guard let data = data(using: .utf8) else { return NSAttributedString() }
    
    if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
      return attributedString
    } else {
      return NSAttributedString()
    }
  }
}


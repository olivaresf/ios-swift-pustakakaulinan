//
//  HTMLText.swift
//  PustakaKaulinan
//
//  Created by Prima Santosa on 23/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation
import SwiftUI

struct HTMLText: UIViewRepresentable {
  let html: String
  
  func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
    let label = UILabel()
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    DispatchQueue.main.async {
      label.attributedText = self.html.convertHtml()
    }
    
    return label
  }
  
  func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<Self>) {}
  
}



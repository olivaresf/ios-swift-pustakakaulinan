//
//  GameScreenshot.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 21/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

struct GameScreenshotResponse: Codable {
  var results: [GameScreenshot]
  
  struct GameScreenshot: Codable, Identifiable {
    var id: Int?
    var image: String?
  }
}


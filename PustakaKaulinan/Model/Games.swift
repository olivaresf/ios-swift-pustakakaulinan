//
//  Games.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 12/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

struct GamesResponse: Codable {
  var results: [Games]
  
  struct Games: Codable, Identifiable, Equatable {
    static func == (lhs: GamesResponse.Games, rhs: GamesResponse.Games) -> Bool {
      return lhs.name == rhs.name
    }
    
    var id: Int?
    var name: String?
    var released: String?
    var description: String?
    var tba: Bool?
    var background_image: String?
    var metacritic: Int?
    var rating: Double?
    var rating_top: Double?
    var genres: [Genre]?
    var developers: [Developer]?
    var publishers: [Publisher]?
    var short_screenshots: [Screenshot]?
    
    struct Genre: Codable, Identifiable {
      var id: Int?
      var name: String?
    }
    
    struct Developer: Codable, Identifiable {
      var id: Int?
      var name: String?
    }
    
    struct Publisher: Codable, Identifiable {
      var id: Int?
      var name: String?
    }
    
    struct Screenshot: Codable, Identifiable {
      var id: Int?
      var image: String?
    }
  }
}


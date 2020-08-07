//
//  Genreswift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

struct GenreResponse: Codable {
  var results: [Genre]
  
  struct Genre: Codable, Identifiable {
    var id: Int?
    var name: String?
    var image_background: String?
    var description: String?
    var games: [Games]?
    
    struct Games: Codable, Identifiable {
      var id: Int
      var name: String
    }
  }
}


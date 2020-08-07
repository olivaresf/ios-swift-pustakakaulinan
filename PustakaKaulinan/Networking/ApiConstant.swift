//
//  ApiConstant.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

private enum Ordering: String {
  case added = "added"
  case rating = "rating"
  case released = "released"
  case popularity = "popularity"
}

private let baseUrl = "https://api.rawg.io/api"

private let pageSize = "20"

struct ApiConstant {
  static let genres = "\(baseUrl)/genres"
  
  static let games = "\(baseUrl)/games"
  
  static let upcomingGames = "\(baseUrl)/games?ordering=-\(Ordering.added)&page_size=\(pageSize)&dates=\(DateUtils.currentDate),\(DateUtils.nextYear)"
  
  static let highestRatedGames = "\(baseUrl)/games?ordering=-\(Ordering.rating)&page_size=\(pageSize)"
  
  static let newestReleasedGames = "\(baseUrl)/games?ordering=-\(Ordering.released)&page_size=\(pageSize)&dates=\(DateUtils.lastMonth),\(DateUtils.currentDate)"
  
  static let mostPopularPCGames = "\(baseUrl)/games?ordering=-\(Ordering.added)&page_size=\(pageSize)&platforms=4"
  
  static let mostPopularRacingGames = "\(baseUrl)/games?ordering=-\(Ordering.added)&page_size=\(pageSize)&genres=racing"
}


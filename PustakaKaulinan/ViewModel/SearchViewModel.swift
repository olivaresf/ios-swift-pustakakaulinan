//
//  SearchViewModel.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 18/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class SearchViewModel: ObservableObject {
  private let network = ApiService()
  
  var nextPage: String? = nil
  
  @Published var gamesList = [GamesResponse.Games]()
  @Published var isError = false
  @Published var isLoading = false
  
  func loadGamesByKeyword(keyword: String) {
    isError = false
    isLoading = true
    gamesList = [GamesResponse.Games]()
    
    network.loadGamesBySearch(
      url: "\(ApiConstant.games)?search=\(keyword)"
    ) { result in
      switch result {
      case .failure:
        DispatchQueue.main.async {
          self.isError = true
          self.isLoading = false
        }
      case .success(let games):
        DispatchQueue.main.async {
          self.gamesList = games.results
          self.isLoading = false
        }
      }
    }
  }
}



//
//  GenreDetailViewModel.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class GenreDetailViewModel: ObservableObject {
  private let network = ApiService()
  
  var nextPage: String? = nil
  
  @Published var genreDetail = GenreResponse.Genre()
  @Published var gamesList = [GamesResponse.Games]()
  @Published var isError = false
  @Published var isLoading = false
  @Published var isLoadingNext = false
  
  func loadGenreDetail(genreId: Int) {
    isError = false
    
    network.loadGenreDetail(genreID: genreId) { result in
      switch result {
      case .failure:
        self.isError = true
      case .success(let genre):
        DispatchQueue.main.async {
          self.genreDetail = genre
        }
      }
    }
  }
  
  func loadGamesByGenre(genreId: Int) {
    isError = false
    isLoading = true
    
    network.loadGamesByGenre(
      url: "\(ApiConstant.games)?genres=\(genreId)"
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



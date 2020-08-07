//
//  GameDetailViewModel.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 16/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class GameDetailViewModel: ObservableObject {
  private let network = ApiService()
  
  @Published var gameDetail = GamesResponse.Games()
  @Published var gameScreenshots = [GameScreenshotResponse.GameScreenshot]()
  @Published var isError = false
  @Published var isLoading = false
  
  func loadGameDetail(gameId: Int) {
    isError = false
    isLoading = true
    
    network.loadGameDetail(gameId: gameId) { result in
      switch result {
      case .failure:
        self.isError = true
        self.isLoading = false
      case .success(let game):
        DispatchQueue.main.async {
          self.gameDetail = game
          self.isLoading = false
        }
      }
    }
  }
  
  func loadGameScreenshots(gameId: Int) {
    isError = false
    
    network.loadGameScreenshots(
      url: "\(ApiConstant.games)/\(gameId)/screenshots"
    ) { result in
      switch result {
      case .failure:
        self.isError = true
      case .success(let gameScreenshots):
        DispatchQueue.main.async {
          self.gameScreenshots = gameScreenshots.results
        }
      }
    }
  }
}




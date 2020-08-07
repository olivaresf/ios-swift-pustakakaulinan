//
//  HomeViewModel.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
  private let network = ApiService()
  
  @Published var upcomingGames = [GamesResponse.Games]()
  @Published var highestRatedGames = [GamesResponse.Games]()
  @Published var newestReleasedGames = [GamesResponse.Games]()
  @Published var mostPopularPCGames = [GamesResponse.Games]()
  @Published var mostPopularRacingGames = [GamesResponse.Games]()
  @Published var isError = false
  @Published var isLoading = false
  
  func loadData() {
    isError = false
    isLoading = true
    
    network.loadHomeFeed(
      upcomingGamesCompletion: { result in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self.isError = true
            self.isLoading = false
          }
        case .success(let feed):
          DispatchQueue.main.async {
            self.upcomingGames = feed.results
            self.isLoading = false
          }
        }
    },
      highestRatedGamesCompletion: { result in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self.isError = true
            self.isLoading = false
          }
        case .success(let feed):
          DispatchQueue.main.async {
            self.highestRatedGames = feed.results
            self.isLoading = false
          }
        }
    },
      newestReleasedGamesCompletion: { result in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self.isError = true
            self.isLoading = false
          }
        case .success(let feed):
          DispatchQueue.main.async {
            self.newestReleasedGames = feed.results
            self.isLoading = false
          }
        }
    },
      mostPopularPCGamesCompletion: { result in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self.isError = true
            self.isLoading = false
          }
        case .success(let feed):
          DispatchQueue.main.async {
            self.mostPopularPCGames = feed.results
            self.isLoading = false
          }
        }
    },
      mostPopularRacingGamesCompletion: { result in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self.isError = true
            self.isLoading = false
          }
        case .success(let feed):
          DispatchQueue.main.async {
            self.mostPopularRacingGames = feed.results
            self.isLoading = false
          }
        }
    }
    )
  }
}


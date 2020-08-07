//
//  RawrApiService.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 12/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

// DEBUGGING:
// print(String(data: data, encoding: String.Encoding.utf8)! as String)

class ApiService {
  private let sessionManager = URLSession.shared
  
  private func loadUrl(url: String) -> URLRequest? {
    guard let url = URL(string: url) else {
      print("Please input a valid URL")
      return nil
    }
    
    return URLRequest(url: url)
  }
  
  private func loadDataFromUrl<T: Codable>(
    urlRequest: String,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    if let url = loadUrl(url: urlRequest) {
      sessionManager.dataTask(with: url) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }
        
        if let data = data {
          let result = Result {
            try JSONDecoder().decode(T.self, from: data)
          }
          completion(result)
        }
      }.resume()
    }
  }
  
  func loadGenreList(
    completion: @escaping (Result<GenreResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlRequest: ApiConstant.genres, completion: completion)
  }
  
  func loadGenreDetail(
    genreID: Int,
    completion: @escaping (Result<GenreResponse.Genre, Error>) -> Void
  ) {
    loadDataFromUrl(
      urlRequest: "\(ApiConstant.genres)/\(genreID)",
      completion: completion
    )
  }
  
  func loadHomeFeed(
    upcomingGamesCompletion: @escaping (Result<GamesResponse, Error>) -> Void,
    highestRatedGamesCompletion: @escaping (Result<GamesResponse, Error>) -> Void,
    newestReleasedGamesCompletion: @escaping (Result<GamesResponse, Error>) -> Void,
    mostPopularPCGamesCompletion: @escaping (Result<GamesResponse, Error>) -> Void,
    mostPopularRacingGamesCompletion: @escaping (Result<GamesResponse, Error>) -> Void
  ) {
    loadDataFromUrl(
      urlRequest: ApiConstant.upcomingGames,
      completion: upcomingGamesCompletion
    )
    loadDataFromUrl(
      urlRequest: ApiConstant.highestRatedGames,
      completion: highestRatedGamesCompletion
    )
    loadDataFromUrl(
      urlRequest: ApiConstant.newestReleasedGames,
      completion: newestReleasedGamesCompletion
    )
    loadDataFromUrl(
      urlRequest: ApiConstant.mostPopularPCGames,
      completion: mostPopularPCGamesCompletion
    )
    loadDataFromUrl(
      urlRequest: ApiConstant.mostPopularRacingGames,
      completion: mostPopularRacingGamesCompletion
    )
  }
  
  func loadGameDetail(
    gameId: Int,
    completion: @escaping (Result<GamesResponse.Games, Error>) -> Void
  ) {
    loadDataFromUrl(
      urlRequest: "\(ApiConstant.games)/\(gameId)",
      completion: completion
    )
  }
  
  func loadGamesByGenre(
    url: String,
    completion: @escaping (Result<GamesResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlRequest: url, completion: completion)
  }
  
  func loadGamesBySearch(
    url: String,
    completion: @escaping (Result<GamesResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlRequest: url, completion: completion)
  }
  
  func loadGameScreenshots(
    url: String,
    completion: @escaping (Result<GameScreenshotResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlRequest: url, completion: completion)
  }
}






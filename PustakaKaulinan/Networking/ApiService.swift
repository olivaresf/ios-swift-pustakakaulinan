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
  
  private func loadDataFromUrl<T: Codable>(
    urlString: String,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
		
		let url = URL(string: urlString)!
		let request = URLRequest(url: url)
		let dataTask = sessionManager.dataTask(with: request) { possibleData, possibleResponse, possibleError in
			if let error = possibleError {
				completion(.failure(error))
				return
			}
			
			if let data = possibleData {
				let result = Result {
					try JSONDecoder().decode(T.self, from: data)
				}
				completion(result)
			}
		}
		
		dataTask.resume()
  }
  
  func loadGenreList(
    completion: @escaping (Result<GenreResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlString: ApiConstant.genres, completion: completion)
  }
  
  func loadGenreDetail(
    genreID: Int,
    completion: @escaping (Result<GenreResponse.Genre, Error>) -> Void
  ) {
    loadDataFromUrl(
      urlString: "\(ApiConstant.genres)/\(genreID)",
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
      urlString: ApiConstant.upcomingGames,
      completion: upcomingGamesCompletion
    )
    loadDataFromUrl(
      urlString: ApiConstant.highestRatedGames,
      completion: highestRatedGamesCompletion
    )
    loadDataFromUrl(
      urlString: ApiConstant.newestReleasedGames,
      completion: newestReleasedGamesCompletion
    )
    loadDataFromUrl(
      urlString: ApiConstant.mostPopularPCGames,
      completion: mostPopularPCGamesCompletion
    )
    loadDataFromUrl(
      urlString: ApiConstant.mostPopularRacingGames,
      completion: mostPopularRacingGamesCompletion
    )
  }
  
  func loadGameDetail(
    gameId: Int,
    completion: @escaping (Result<GamesResponse.Games, Error>) -> Void
  ) {
    loadDataFromUrl(
      urlString: "\(ApiConstant.games)/\(gameId)",
      completion: completion
    )
  }
  
  func loadGamesByGenre(
    url: String,
    completion: @escaping (Result<GamesResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlString: url, completion: completion)
  }
  
  func loadGamesBySearch(
    url: String,
    completion: @escaping (Result<GamesResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlString: url, completion: completion)
  }
  
  func loadGameScreenshots(
    url: String,
    completion: @escaping (Result<GameScreenshotResponse, Error>) -> Void
  ) {
    loadDataFromUrl(urlString: url, completion: completion)
  }
}






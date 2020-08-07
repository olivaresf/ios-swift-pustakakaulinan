//
//  ExploreViewModel.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class ExploreViewModel: ObservableObject {
  private let network = ApiService()
  
  @Published var genreList = [GenreResponse.Genre]()
  @Published var isError = false
  @Published var isLoading = false
  
  func loadGenreList() {
    isError = false
    isLoading = true
    
    network.loadGenreList() { result in
      switch result {
      case .failure:
        self.isError = true
        self.isLoading = false
      case .success(let genre):
        DispatchQueue.main.async {
          self.genreList = genre.results
          self.isLoading = false
        }
      }
    }
  }
}


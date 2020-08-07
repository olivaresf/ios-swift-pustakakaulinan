//
//  HomeCardDetailView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 16/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct HomeCardDetailView: View {
  var title: String
  var games: [GamesResponse.Games]
  
  var body: some View {
    List {
      ForEach(games) { game in
        NavigationLink(destination: GameDetailView(game: game)) {
          GameRowView(game: game, type: "rating")
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
    .navigationBarTitle("\(title)")
  }
}

struct HomeCardDetailView_Previews: PreviewProvider {
  static var previews: some View {
    HomeCardDetailView(title: "Upcoming Games", games: [GamesResponse.Games]())
  }
}


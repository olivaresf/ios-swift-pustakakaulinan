//
//  GameDetailMetadataView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 17/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct GameDetailMetadataView: View {
  var gameDetail: GamesResponse.Games
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack (alignment: .center){
        VStack {
          Text("Rating")
            .font(.headline)
          
          if gameDetail.rating == 0.0 {
            Text("N/A")
              .foregroundColor(.gray)
          } else {
            HStack(spacing: 0) {
              Text(String(format: "%.2f", gameDetail.rating ?? 0))
                .foregroundColor(.gray)
              
              Text(" / 5")
                .foregroundColor(.gray)
            }
          }
        }
        
        Spacer()
        
        VStack {
          Text("Metascore")
            .font(.headline)
          Text("\(gameDetail.metacritic ?? 0)")
            .foregroundColor(.gray)
        }
        
        Spacer()
        
        VStack {
          Text("Release Date")
            .font(.headline)
          Text("\(gameDetail.released ?? "TBA")")
            .foregroundColor(.gray)
        }
      }
      
      Spacer()
        .frame(height: 20)
      
      VStack(alignment: .leading) {
        Text("About Game")
          .font(.title)
          .bold()
        
        HTMLText(html: gameDetail.description ?? "No description available")
      }
      
      VStack(alignment: .leading) {
        VStack(alignment: .leading) {
          Text("Developer")
            .font(.system(size: 22))
            .bold()
          
          ForEach(gameDetail.developers ??
            [GamesResponse.Games.Developer(id: 1, name: "N/A")]
          ) { developer in
            Text("\(developer.name ?? "N/A")")
              .foregroundColor(.gray)
          }
        }
        
        Spacer()
          .frame(height: 20)
        
        VStack(alignment: .leading) {
          Text("Publisher")
            .font(.system(size: 22))
            .bold()
          ForEach(gameDetail.publishers ??
            [GamesResponse.Games.Publisher(id: 1, name: "N/A")]
          ) { publisher in
            Text("\(publisher.name ?? "N/A")")
              .foregroundColor(.gray)
          }
        }
        
        Spacer()
          .frame(height: 20)
        
        VStack(alignment: .leading) {
          Text("Genre")
            .font(.system(size: 22))
            .bold()
          ForEach(self.gameDetail.genres ??
            [GamesResponse.Games.Genre(id: 1, name: "N/A")]
          ) { genre in
            Text("\(genre.name ?? "N/A")")
              .foregroundColor(.gray)
          }
        }
      }
      .padding(.trailing, 50)
    }
    .padding()
  }
}

struct GameDetailRowView_Previews: PreviewProvider {
  static var previews: some View {
    GameDetailMetadataView(gameDetail: GamesResponse.Games())
  }
}





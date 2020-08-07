//
//  GameRowView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 15/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor

struct GameRowView: View {
  var game: GamesResponse.Games
  var type: String
  
  @State var gameRank = 0
  
  var body: some View {
    VStack {
      HStack {
        KFImage(
          URL(string: game.background_image ?? ""),
          options: [
            .transition(.fade(1)),
            .processor(
              DownsamplingImageProcessor(size: CGSize(width: 180, height: 180))
            ),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
          ]
        )
          .placeholder {
            Image(systemName: "arrow.2.circlepath.circle")
              .font(.largeTitle)
              .opacity(0.3)
        }
        .cancelOnDisappear(true)
        .resizable()
        .frame(width: 60, height: 60)
        .cornerRadius(10)
        .shadow(radius: 5)
        
        VStack(alignment: .leading, spacing: 0) {
          Text(game.name ?? "")
            .bold()
            .font(.headline)
          
          Text("Release Date: \(game.released ?? "")")
            .font(.subheadline)
            .foregroundColor(.gray)
          
          Spacer()
            .frame(height: 2)
          
          
          if type == "rating" {
            HStack(spacing: 3) {
              Image(systemName: "star.fill")
                .font(.system(size: 14))
                .foregroundColor(.yellow)
              
              if game.rating == 0.0 {
                Text("N/A")
                  .font(.subheadline)
                  .foregroundColor(.gray)
              } else {
                Text(String(format: "%.2f", game.rating ?? 0))
                  .font(.subheadline)
                  .foregroundColor(.gray)
              }
            }
          }
          
          if type == "rank" {
            Text("# \(gameRank + 1)")
              .font(.subheadline)
              .foregroundColor(.gray)
          }
        }
        
        Spacer()
      }
    }
    .padding(.vertical, 5)
  }
}

struct GamesRowView_Previews: PreviewProvider {
  static var previews: some View {
    GameRowView(
      game: GamesResponse.Games(
        name: "Grand Theft Auto V",
        released: "September 17, 2013",
        background_image:
        "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg"
      ),
      type: "rating"
    )
  }
}



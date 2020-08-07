//
//  GenreRowView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor

struct GenreRowView: View {
  var genre: GenreResponse.Genre
  
  var body: some View {
    VStack {
      ZStack {
        KFImage(
          URL(string: genre.image_background ?? ""),
          options: [
            .transition(.fade(1)),
            .processor(
              DownsamplingImageProcessor(size: CGSize(width: 380, height: 300)
              )
            ),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
          ]
        )
          .cancelOnDisappear(true)
          .resizable()
          .scaledToFill()
          .frame(width: 300)
          .shadow(radius: 5)
        
        LinearGradient(
          gradient: Gradient(
            colors: [Color.black.opacity(0.3), Color.black.opacity(0.5)]
          ),
          startPoint: .top,
          endPoint: .bottom
        )
        
        VStack {
          Text(genre.name ?? "")
            .foregroundColor(Color.white)
            .font(.title)
            .bold()
          
        }
      }
      .frame(height: 300)
      .cornerRadius(30)
      .shadow(radius: 5)
    }
    .padding(.horizontal)
    .padding(.bottom)
  }
}

struct CategoryRowView_Previews: PreviewProvider {
  static var previews: some View {
    GenreRowView(
      genre: GenreResponse.Genre(
        id: 1,
        name: "Action",
        image_background:
        "https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg",
        games: []
      )
    )
  }
}




//
//  GenreDetailView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 12/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor

struct GenreDetailView: View {
  private var id: Int
  
  @ObservedObject private var viewModel = GenreDetailViewModel()
  
  @Environment(\.presentationMode) var presentationMode
  
  @State private var isLoading = false
  
  var body: some View {
    GeometryReader { geo in
      if self.viewModel.isError {
        VStack(alignment: .center) {
          Spacer()
          Text("Sorry, currently something's not right.")
            .font(.system(size: 18))
          Button(action: {self.viewModel.loadGamesByGenre(genreId: self.id)}) {
            Text("Try Again")
          }
        }
        .frame(width: geo.size.width, height: geo.size.height / 2)
      }
      
      if self.viewModel.isLoading {
        VStack(alignment: .center) {
          Spacer()
          Text("Loading...")
            .font(.system(size: 18))
        }
        .frame(width: geo.size.width, height: geo.size.height / 2)
      }
      
      if !self.viewModel.isLoading && !self.viewModel.isError {
        ScrollView(.vertical) {
          VStack {
            KFImage(
              URL(string: self.viewModel.genreDetail.image_background ?? ""),
              options: [
                .transition(.fade(1)),
                .processor(
                  DownsamplingImageProcessor(
                    size: CGSize(width: geo.size.width, height: 700)
                  )
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
            .scaledToFill()
            .frame(width: geo.size.width, height: 400)
            .shadow(radius: 5)
            
            VStack(alignment: .leading) {
              Text(self.viewModel.genreDetail.name ?? "")
                .font(.title)
                .bold()
              
              Spacer()
              
              HTMLText(
                html: self.viewModel.genreDetail.description ??
                "No description available"
              )
              
              Spacer()
              
              Text("Games")
                .font(.title)
                .bold()
              
              ForEach(self.viewModel.gamesList) { game in
                NavigationLink(destination: GameDetailView(game: game)) {
                  // Response returned from API automatically
                  // sorted by popularity
                  // This means to retrieved game rank information,
                  // we just needs to loop through its index. Voila!
                  GameRowView(
                    game: game,
                    type: "rank",
                    gameRank: self.viewModel.gamesList.firstIndex(of: game) ?? 0
                  )
                }
                .buttonStyle(PlainButtonStyle())
              }
            }
            .padding()
          }
        }
      }
    }
    .navigationBarTitle(
      "\(self.viewModel.genreDetail.name ?? "Genre Detail")",
      displayMode: .inline
    )
  }
  
  init(genreId: Int) {
    self.id = genreId
    viewModel.loadGenreDetail(genreId: id)
    viewModel.loadGamesByGenre(genreId: id)
  }
}

struct GenreDetailView_Previews: PreviewProvider {
  static var previews: some View {
    GenreDetailView(genreId: 4)
  }
}



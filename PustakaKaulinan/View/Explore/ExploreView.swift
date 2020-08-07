//
//  BrowseView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
  @ObservedObject private var viewModel = ExploreViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        ScrollView {
          VStack {
            HeadingRowView(title: "Explore")
            
            if self.viewModel.isError {
              VStack(alignment: .center) {
                Spacer()
                Text("Sorry, currently something's not right.")
                  .font(.system(size: 18))
                Button(action: {self.viewModel.loadGenreList()}) {
                  Text("Try Again")
                }
              }
              .frame(height: geo.size.height / 2)
            }
            
            if self.viewModel.isLoading {
              VStack(alignment: .center) {
                Spacer()
                Text("Loading...")
                  .font(.system(size: 18))
              }
              .frame(height: geo.size.height / 2)
            }
            
            if !self.viewModel.isLoading && !self.viewModel.isError {
              ForEach(self.viewModel.genreList) { item in
                NavigationLink(
                  destination: GenreDetailView(genreId: item.id ?? 0)
                ) {
                  GenreRowView(
                    genre: GenreResponse.Genre(
                      id: item.id,
                      name: item.name,
                      image_background: item.image_background,
                      games: item.games)
                  )
                }
                .buttonStyle(PlainButtonStyle())
              }
            }
          }
        }
      }
      .navigationBarHidden(true)
      .navigationBarTitle(Text("Explore"))
    }
  }
  
  init() {
    viewModel.loadGenreList()
  }
}

struct ExploreView_Previews: PreviewProvider {
  static var previews: some View {
    ExploreView()
  }
}




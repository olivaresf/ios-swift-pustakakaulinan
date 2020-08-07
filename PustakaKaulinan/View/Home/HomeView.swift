//
//  HomeView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  private let upcomingGames = "Upcoming Games"
  private let highestRatedGames = "Highest Rated Games"
  private let mostPopularRacingGames = "Most Popular Racing Games"
  private let newestReleasedGames = "Newest Released Games"
  private let mostPopularPCGames = "Most Popular PC Games"
  
  @ObservedObject private var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        ScrollView {
          VStack {
            HeadingRowView(title: "Home")
            
            if self.viewModel.isError {
              VStack(alignment: .center) {
                Spacer()
                Text("Sorry, currently something's not right.")
                  .font(.system(size: 18))
                Button(action: {self.viewModel.loadData()}) {
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
            
            if !self.viewModel.upcomingGames.isEmpty {
              NavigationLink(
                destination: HomeCardDetailView(
                  title: self.upcomingGames,
                  games: self.viewModel.upcomingGames
                )
              ) {
                HomeCardView(
                  title: self.upcomingGames,
                  image: self.viewModel.upcomingGames[0].background_image ?? ""
                )
              }
              .buttonStyle(PlainButtonStyle())
            }
            
            if !self.viewModel.highestRatedGames.isEmpty {
              NavigationLink(
                destination: HomeCardDetailView(
                  title: self.highestRatedGames,
                  games: self.viewModel.highestRatedGames
                )
              ) {
                HomeCardView(
                  title: self.highestRatedGames,
                  image:
                  self.viewModel.highestRatedGames[0].background_image ?? ""
                )
              }
              .buttonStyle(PlainButtonStyle())
            }
            
            if !self.viewModel.mostPopularRacingGames.isEmpty {
              NavigationLink(
                destination: HomeCardDetailView(
                  title: self.mostPopularRacingGames,
                  games: self.viewModel.mostPopularRacingGames
                )
              ) {
                HomeCardView(
                  title: self.mostPopularRacingGames,
                  image:
                  self.viewModel.mostPopularRacingGames[0].background_image ?? ""
                )
              }
              .buttonStyle(PlainButtonStyle())
            }
            
            if !self.viewModel.newestReleasedGames.isEmpty {
              NavigationLink(
                destination: HomeCardDetailView(
                  title: self.newestReleasedGames,
                  games: self.viewModel.newestReleasedGames
                )
              ) {
                HomeCardView(
                  title: self.newestReleasedGames,
                  image:
                  self.viewModel.newestReleasedGames[0].background_image ?? ""
                )
              }
              .buttonStyle(PlainButtonStyle())
            }
            
            if !self.viewModel.mostPopularPCGames.isEmpty {
              NavigationLink(
                destination: HomeCardDetailView(
                  title: self.mostPopularPCGames,
                  games: self.viewModel.mostPopularPCGames
                )
              ) {
                HomeCardView(
                  title: self.mostPopularPCGames,
                  image:
                  self.viewModel.mostPopularPCGames[0].background_image ?? ""
                )
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      .navigationBarHidden(true)
      .navigationBarTitle(Text("Home"))
    }
  }
  
  init() {
    viewModel.loadData()
  }
}


struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}





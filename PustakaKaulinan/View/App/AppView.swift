//
//  AppView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct AppView: View {
  
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Image(systemName: "house")
          Text("Home")
      }
      ExploreView()
        .tabItem {
          Image(systemName: "safari")
          Text("Explore")
      }
      MyFavoritesView()
        .tabItem {
          Image(systemName: "heart.fill")
          Text("My Favorites")
      }
      SearchView()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}


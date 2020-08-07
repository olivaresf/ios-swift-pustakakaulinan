//
//  SearchView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject private var viewModel = SearchViewModel()
  
  @State private var keyword = ""
  @State private var loadPlaceholderText = true
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        VStack {
          HeadingRowView(title: "Search")
        }
        
        VStack {
          HStack {
            TextField(
              "Search for a game title",
              text: self.$keyword,
              onCommit: self.searchGamesByKeyword
            )
              .padding(10)
              .padding(.horizontal, 10)
              .background(Color(.systemGray6))
              .cornerRadius(8)
          }
          .padding(.horizontal)
          .padding(.bottom, 10)
          .padding(.top, 100)
          
          if self.viewModel.isError {
            VStack(alignment: .center) {
              Text("Sorry, currently something's not right.")
                .font(.system(size: 18))
              Button(
                action: {
                  self.viewModel.loadGamesByKeyword(keyword: self.keyword)
              }) {
                Text("Try Again")
              }
            }
            .frame(height: geo.size.height / 1.5)
          }
          
          if self.viewModel.isLoading {
            VStack(alignment: .center) {
              Text("Loading...")
                .font(.system(size: 18))
            }
            .frame(height: geo.size.height / 1.5)
          }
          
          if self.loadPlaceholderText {
            VStack(alignment: .center) {
              Text("Your search results will appear here")
            }
            .frame(height: geo.size.height / 1.5)
          }
          
          VStack {
            if self.viewModel.gamesList.isEmpty && !self.loadPlaceholderText {
              VStack(alignment: .center) {
                Text("No results found")
              }
              .frame(height: geo.size.height / 1.5)
            }
            
            if !self.viewModel.gamesList.isEmpty && !self.loadPlaceholderText {
              List {
                ForEach(self.viewModel.gamesList) { game in
                  NavigationLink(destination: GameDetailView(game: game)) {
                    GameRowView(game: game,type: "rating")
                  }
                  .buttonStyle(PlainButtonStyle())
                }
              }
            }
            
          }
        }
      }
      .navigationBarHidden(true)
      .navigationBarTitle("Search", displayMode: .inline)
    }
  }
  
  func searchGamesByKeyword() {
    if keyword == "" {
      return
    }
    
    // Replace whitespace with dash
    let filteredKeyword = keyword.replacingOccurrences(of: " ", with: "-")
    
    if loadPlaceholderText {
      loadPlaceholderText.toggle()
    }
    
    viewModel.loadGamesByKeyword(keyword: filteredKeyword)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}




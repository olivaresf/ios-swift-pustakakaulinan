//
//  GameDetailView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 12/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import CoreData

struct GameDetailView: View {
  // This one passed from previous screen contains short_screenshots
  private var game: GamesResponse.Games
  private var fetchedRequest: FetchRequest<Library>
  
  @Environment(\.managedObjectContext) var moc
  
  @ObservedObject private var viewModel = GameDetailViewModel()
  
  @State private var isAlertVisible = false
  @State private var alertMessage = ""
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        if self.viewModel.isError {
          VStack(alignment: .center) {
            Spacer()
            Text("Sorry, currently something's not right.")
              .font(.system(size: 18))
            Button(action: {
              self.viewModel.loadGameDetail(gameId: self.game.id ?? 0)}
            ) {
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
        
        if !(self.viewModel.gameDetail.developers?.isEmpty ?? true) {
          VStack {
            // Using game object from previous screen
            // which contains short_screenshots
            GameDetailImageCarouselView(
              gameScreenshots: self.viewModel.gameScreenshots,
              geoWidth: geo.size.width
            )
            
            // Using game detail object fetched from network
            // (does not contain short_screenshots)
            GameDetailMetadataView(gameDetail: self.viewModel.gameDetail)
          }
        }
      }
    }
    .navigationBarItems(trailing:
      Button(action: {
        if self.fetchedRequest.wrappedValue.count > 0 {
          self.moc.delete(self.fetchedRequest.wrappedValue.first!)
          
          self.alertMessage =
          "Successfully removed \(self.game.name ?? "this game") from favorites"
        } else {
          let library = Library(context: self.moc)
          library.id = Int64(self.game.id ?? 0)
          library.title = self.game.name
          library.image = self.game.background_image
          library.rating = String(format: "%.2f", self.game.rating ?? "N/A")
          library.releaseDate = self.game.released
          
          self.alertMessage =
          "Successfully added \(self.game.name ?? "this game") to favorites"
        }
        
        if self.moc.hasChanges {
          try? self.moc.save()
        }
        
        self.isAlertVisible = true
        
      }) {
        if self.fetchedRequest.wrappedValue.count > 0 {
          Image(systemName: "heart.fill")
        } else {
          Image(systemName: "heart")
        }
      }
    )
      .navigationBarTitle("\(game.name ?? "")", displayMode: .inline)
      .alert(isPresented: $isAlertVisible) {
        Alert(
          title: Text("Success!"),
          message: Text(alertMessage),
          dismissButton: .default(Text("Great"))
        )
    }
  }
  
  init(game: GamesResponse.Games) {
    self.game = game
    fetchedRequest = FetchRequest(
      entity: Library.entity(),
      sortDescriptors: [],
      predicate: NSPredicate(format: "id == %d", Int64(self.game.id ?? 0))
    )
    viewModel.loadGameDetail(gameId: self.game.id ?? 0)
    viewModel.loadGameScreenshots(gameId: self.game.id ?? 0)
  }
}





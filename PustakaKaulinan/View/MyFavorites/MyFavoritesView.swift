//
//  MyFavoritesView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 21/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct MyFavoritesView: View {
  
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(entity: Library.entity(), sortDescriptors: [
    NSSortDescriptor(keyPath: \Library.title, ascending: true)
  ]) var library: FetchedResults<Library>
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        VStack {
          HeadingRowView(title: "My Favorites")
        }
        
        VStack {
          if self.library.isEmpty {
            VStack(alignment: .center) {
              Text("Start by adding your favorite games")
            }
            .frame(height: geo.size.height / 1.5)
          } else {
            List {
              ForEach(self.library, id: \.self) { game in
                NavigationLink(
                  destination: GameDetailView(
                    game: GamesResponse.Games(
                      id: Int(game.id),
                      name: game.title
                    )
                  )
                ) {
                  GameRowView(
                    game: GamesResponse.Games(
                      id: Int(game.id),
                      name: game.title,
                      released: game.releaseDate,
                      background_image: game.image,
                      rating: Double(game.rating ?? "0")),
                    type: "rating"
                  )
                }
                .buttonStyle(PlainButtonStyle())
              }
              .onDelete(perform: self.deleteGameFromLibrary)
            }
          }
        }
        .padding(.top, 100)
      }
      .navigationBarHidden(true)
      .navigationBarTitle(Text("My Favorites"))
    }
  }
  
  func deleteGameFromLibrary(at offsets: IndexSet) {
    for offset in offsets {
      let game = library[offset]
      self.moc.delete(game)
    }
    
    if moc.hasChanges {
      try? moc.save()
    }
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    MyFavoritesView()
  }
}





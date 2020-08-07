//
//  HomeCardView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor

struct HomeCardView: View {
  var title: String
  var image: String
  
  var body: some View {
    VStack {
      ZStack {
        KFImage(
          URL(string: image),
          options: [
            .transition(.fade(1)),
            .processor(
              DownsamplingImageProcessor(size: CGSize(width: 500, height: 700))
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
          HStack {
            Text(title)
              .foregroundColor(Color.white)
              .font(.title)
              .bold()
            
            Spacer()
          }
          .padding(.horizontal, 10)
          
          Spacer()
        }
        .padding()
      }
    }
    .frame(height: 450, alignment: .leading)
    .cornerRadius(30)
    .padding(.horizontal)
    .padding(.bottom)
    .shadow(radius: 5)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    HomeCardView(
      title: "Upcoming Games",
      image:
      "https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg"
    )
  }
}




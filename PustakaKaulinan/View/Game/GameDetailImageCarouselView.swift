//
//  GameDetailImageCarouselView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 17/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor
import Combine

struct GameDetailImageCarouselView: View {
  private var gameScreenshots: [GameScreenshotResponse.GameScreenshot]
  private var numberOfScreenshot: Int = 0
  private var geoWidth: CGFloat
  private let timer =
    Timer.publish(every: 3, on: .main, in: .common).autoconnect()
  
  @State private var currentIndex = 0
  
  var body: some View {
    HStack(spacing: 0) {
      if numberOfScreenshot > 0 {
        ForEach(self.gameScreenshots) { item in
          ZStack(alignment: .bottom) {
            KFImage(
              URL(string: item.image ?? ""),
              options: [
                .transition(.fade(1)),
                .processor(
                  DownsamplingImageProcessor(
                    size: CGSize(width: self.geoWidth, height: 250)
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
            .resizable()
            .frame(width: self.geoWidth, height: 250 )
            
            HStack(spacing: 3) {
              ForEach(0..<(self.numberOfScreenshot )) { index in
                Circle()
                  .frame(width: 8, height: 8)
                  .foregroundColor(
                    index == self.currentIndex ? Color.blue : .white
                )
                  .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                  .padding(.bottom, 8)
                  .animation(.spring())
              }
            }
          }
        }
      } else {
        VStack(alignment: .center) {
          Text("No screenshots available")
            .frame(width: self.geoWidth, height: 250)
        }
      }
      
    }
    .frame(width: self.geoWidth, alignment: .leading)
    .offset(x: CGFloat(self.currentIndex) * -self.geoWidth, y: 0)
    .animation(.spring())
    .onReceive(self.timer) { _ in
      if self.numberOfScreenshot != 0 {
        self.currentIndex = (self.currentIndex + 1) % (self.numberOfScreenshot)
      }
    }
  }
  
  init(
    gameScreenshots: [GameScreenshotResponse.GameScreenshot],
    geoWidth: CGFloat
  ) {
    self.gameScreenshots = gameScreenshots
    self.numberOfScreenshot = gameScreenshots.count
    self.geoWidth = geoWidth
  }
}






//
//  GameDetailView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 12/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import struct Kingfisher.DownsamplingImageProcessor

struct GameDetailView: View {
    private var game: GamesResponse.Games
    private var numberOfScreenshot: Int?
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    init(game: GamesResponse.Games) {
        self.game = game
        self.numberOfScreenshot = game.short_screenshots?.count
    }
    
    var body: some View {
            ScrollView {
                GeometryReader { geo in
                    HStack(spacing: 0) {
                        ForEach(self.game.short_screenshots!) { item in
                            ZStack(alignment: .bottom) {
                                 KFImage(
                                    URL(string: item.image ?? ""),
                                    options: [
                                        .transition(.fade(1)),
                                        .processor(DownsamplingImageProcessor(size: CGSize(width: geo.size.width, height: 300))),
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
                                    .frame(width: geo.size.width, height: 300)
                                
                                HStack(spacing: 3) {
                                    ForEach(0..<(self.numberOfScreenshot ?? 0)) { index in
                                        Circle()
                                            .frame(width: index == self.currentIndex ? 10 : 8,
                                                   height: index == self.currentIndex ? 10 : 8)
                                            .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                            .padding(.bottom, 8)
                                            .animation(.spring())
                                    }
                                }
                            }
                        }
                    }
                        .frame(width: geo.size.width, alignment: .leading)
                        .offset(x: CGFloat(self.currentIndex) * -geo.size.width, y: 0)
                        .animation(.spring())
                        .onReceive(self.timer) { _ in
                            self.currentIndex = (self.currentIndex + 1) % (self.numberOfScreenshot ?? 0)
                        }
            }
                
                VStack {
                    Text("\(self.numberOfScreenshot ?? 0)")
                    Text("asdasda")
                }
        }
        .navigationBarTitle("\(game.name ?? "")", displayMode: .inline)
    }
}

struct GamesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: GamesResponse.Games())
    }
}

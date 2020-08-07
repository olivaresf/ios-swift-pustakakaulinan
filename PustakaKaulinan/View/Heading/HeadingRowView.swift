//
//  HeadingRowView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct HeadingRowView: View {
  var title: String
  
  @State private var sheetProfileVisibility = false
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(title)
          .font(.largeTitle)
          .bold()
        
        
        Spacer()
        
        Button(action: {
          self.sheetProfileVisibility.toggle()
        }) {
          Image("Me")
            .renderingMode(.original)
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
        }
      }
    }
    .padding()
    .sheet(isPresented: $sheetProfileVisibility) {
      ProfileView()
    }
  }
}

struct HeadingView_Previews: PreviewProvider {
  static var previews: some View {
    HeadingRowView(title: "Home")
  }
}


//
//  ProfileView.swift
//  PustakaKaulinan
//
//  Created by comprimasantosa on 11/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject private var viewModel = ProfileViewModel()
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        VStack {
          Image("Profile")
            .resizable()
            .scaledToFill()
            .frame(height: 400)
          
          
          Image("Me")
            .renderingMode(.original)
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .offset(y: -120)
            .padding(.bottom,  -110)
          
          VStack {
            Text(self.viewModel.profile.name)
              .font(.title)
              .bold()
            
            Text(self.viewModel.profile.job)
              .font(.subheadline)
            
            Text(self.viewModel.profile.email)
            
            NavigationLink(destination: EditProfileView(
              viewModel: self.viewModel
              )
            ) {
              Text("Edit Profile")
            }
            .padding(.top, 20)
          }
          
          Spacer()
        }
      }
      .edgesIgnoringSafeArea(.all)
      .navigationBarItems(trailing:
        Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "xmark.circle")
            .font(.system(size: 25))
        }
        .buttonStyle(PlainButtonStyle())
      )
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}




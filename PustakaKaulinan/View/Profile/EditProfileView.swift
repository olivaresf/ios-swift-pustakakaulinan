//
//  EditProfileView.swift
//  PustakaKaulinan
//
//  Created by Prima Santosa on 23/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  
  @Environment(\.presentationMode) var presentationMode
  
  @State private var name = ""
  @State private var job = ""
  @State private var email = ""
  
  var body: some View {
    Form {
      Section(header: Text("Name")) {
        TextField("Enter your name", text: $name)
      }
      Section(header: Text("Job")) {
        TextField("Enter your job", text: $job)
      }
      Section(header: Text("Email")) {
        TextField("Enter your email address", text: $email)
      }
    }
    .onAppear(perform: getCurrentProfile)
    .navigationBarTitle("Edit Profile")
    .navigationBarItems(trailing:
      Button(action: {
        self.viewModel.profile = Profile(
          name: self.name,
          job: self.job,
          email: self.email
        )
        
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Save")
      }
      .disabled(name == "" || job == "" || email == "")
    )
  }
  
  private func getCurrentProfile() {
    name = viewModel.profile.name
    job = viewModel.profile.job
    email = viewModel.profile.email
  }
}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView(viewModel: ProfileViewModel())
  }
}




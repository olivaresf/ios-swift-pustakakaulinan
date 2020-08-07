//
//  ProfileViewModel.swift
//  PustakaKaulinan
//
//  Created by Prima Santosa on 23/07/20.
//  Copyright © 2020 comprimasantosa. All rights reserved.
//

import Foundation

class ProfileViewModel: ObservableObject {
  private let defaultName = "Mauliawan Prima Santosa"
  private let defaultJob = "Mobile Apps Developer"
  private let defaultEmail = "trust3d@primasantosa.com"
  
  @Published var profile: Profile {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(profile) {
        UserDefaults.standard.set(encoded, forKey: "profile")
      }
    }
  }
  
  init() {
    if let profile = UserDefaults.standard.data(forKey: "profile") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode(Profile.self, from: profile) {
        self.profile = decoded
        return
      }
    }
    
    // Set default profile when UserDefaults is not available
    // Useful for showing initial state of the app
    self.profile = Profile(
      name: defaultName,
      job: defaultJob,
      email: defaultEmail
    )
  }
}


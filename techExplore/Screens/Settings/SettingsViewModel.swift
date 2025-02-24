//
//  SettingsViewModel.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//

import NetworkManagerFramework
import SwiftUI

final class SettingsViewModel: ObservableObject {
  private let keyService: KeychainService
  @Published var isAssistantOn: Bool {
    didSet {
      UserDefaults.standard.set(isAssistantOn, forKey: "isAssistantEnabled")
    }
  }
  
  init(keyService: KeychainService = KeychainService()) {
    self.keyService = keyService
    self.isAssistantOn = UserDefaults.standard.bool(forKey: "isAssistantEnabled")
  }
  
  func logOut() {
    Task {
      do {
        try keyService.removeTokens()
      } catch {
        print("error logout")
      }
    }
  }
}


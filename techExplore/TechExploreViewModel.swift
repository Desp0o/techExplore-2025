//
//  Router.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//

import Combine

final class TechExploreViewModel: ObservableObject {
  @Published var isUserLogged = false
  @Published var isLoading = true
  private let keychainService: KeychainService
  private let tokenNetwork: TokenNetwork
  
  init(
    keychainService: KeychainService = KeychainService(),
    tokenNetwork: TokenNetwork = TokenNetwork()
  ) {
    self.keychainService = keychainService
    self.tokenNetwork = tokenNetwork
    
    checTokenLife()
  }
  
  func logOut() {
    isUserLogged = false
  }
  
  private func checTokenLife() {
    Task {
      do {
        try await tokenNetwork.getNewToken()
        
        await MainActor.run {
          isUserLogged = true
          isLoading = false
        }
      } catch {
        await MainActor.run {
          isUserLogged = false
          isLoading = false
        }
      }
    }
  }
}

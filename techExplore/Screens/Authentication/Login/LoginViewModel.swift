//
//  LoginViewModel.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import Combine
import NetworkManagerFramework

final class LoginViewModel: ObservableObject {
  private let webService: PostService
  private let keyService: KeychainService
  @Published var email = ""
  @Published var password = ""
  @Published var isPasswordVisible = false
  @Published var errorMessage = ""
  @Published var isAuthenticated = false
  @Published var isLoading = false

  init(
    webService: PostService = PostService(),
    keyService: KeychainService = KeychainService()
  ) {
    self.webService = webService
    self.keyService = keyService
  }
  
  func loginRequest(isAuthenticated: TechExploreViewModel) {
    isLoading = true

    let api = EndpointsEnums.login.rawValue
    let body = LoginModel(email: email, password: password)
    Task {
      do {
        let response : LoginResponseModel = try await webService.postData(urlString: api, body: body)
        
        try keyService.storeTokens(access: response.access, refresh: response.refresh)
        
        await MainActor.run {
          isLoading = false
          isAuthenticated.isUserLogged = true
        }
      } catch {
        await MainActor.run {
          errorMessage = error.localizedDescription
          isLoading = false
        }
      }
    }
  }
}

//
//  TokenNetwork.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//

struct RefreshTokenModel: Codable {
  let refresh: String
}

struct AccessTokenModel: Codable {
  let access: String
}

import NetworkManagerFramework

final class TokenNetwork {
  private let keyService: TokenRetrieveProtocol
  private let webService: PostServiceProtocol
  
  init(
    keyService: TokenRetrieveProtocol = KeychainService(),
    webService: PostServiceProtocol = PostService()
  ) {
    self.keyService = keyService
    self.webService = webService
  }
  
  func getNewToken() async throws {
    guard let refreshToken = try? keyService.retrieveRefreshToken() else {
      throw NetworkError.noData
    }
    
    let url = EndpointsEnums.token.rawValue
    let body = RefreshTokenModel(refresh: refreshToken)
    
    do {
      let response: AccessTokenModel = try await webService.postData(
        urlString: url,
        headers: nil,
        body: body
      )
      try keyService.storeAccessTokens(access: response.access)
    } catch {
      throw error
    }
  }
}

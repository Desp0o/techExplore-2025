//
//  KeychainService.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//


import SimpleKeychain
import NetworkManagerFramework

protocol TokenRetrieveProtocol {
  func retrieveRefreshToken() throws -> String
  func storeAccessTokens(access: String) throws
  func retrieveAccessToken() throws -> String
}

final class KeychainService: TokenRetrieveProtocol {
  let keyService: SimpleKeychain
  
  init(keyService: SimpleKeychain = SimpleKeychain()) {
    self.keyService = keyService
  }
  
  func storeTokens(access: String, refresh: String) throws {
    try keyService.set(access, forKey: keyServiceEnum.accessToken.rawValue)
    try keyService.set(refresh, forKey: keyServiceEnum.refreshToken.rawValue)
  }
  
  func storeAccessTokens(access: String) throws {
    try keyService.set(access, forKey: keyServiceEnum.accessToken.rawValue)
  }
  
  func retrieveAccessToken() throws -> String{
    try keyService.string(forKey: keyServiceEnum.accessToken.rawValue)
  }
  
  func retrieveRefreshToken() throws -> String{
    try keyService.string(forKey: keyServiceEnum.refreshToken.rawValue)
  }
  
  func checkAccessToken() throws -> Bool {
    try keyService.hasItem(forKey: keyServiceEnum.accessToken.rawValue)
  }
  
  func checkRefreshToken() throws -> Bool {
    try keyService.hasItem(forKey: keyServiceEnum.refreshToken.rawValue)
  }
  
  func removeTokens() throws {
    try keyService.deleteItem(forKey: keyServiceEnum.accessToken.rawValue)
    try keyService.deleteItem(forKey: keyServiceEnum.refreshToken.rawValue)
  }
}

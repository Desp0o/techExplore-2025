//
//  HomeViewModel.swift
//  techExplore
//
//  Created by Despo on 20.02.25.
//

import SwiftUI
import Combine
import NetworkManagerFramework

final class HomeViewModel: ObservableObject {
  @AppStorage("isAssistantEnabled") var isAssistantOn = false
  @Published var userCard: CardModel? = nil
  @Published var transactions: [TransactionModel] = []
  private let speechManager: SpeechManager?
  private let networkService: NetworkServiceProtocol
  private let keyService: KeychainService
  private let tokenNetwork: TokenNetwork
  
  init(
    speechManager: SpeechManager = SpeechManager(),
    networkService: NetworkServiceProtocol = NetworkService(),
    keyService: KeychainService = KeychainService(),
    tokenNetwork: TokenNetwork = TokenNetwork()
  ) {
    self.speechManager = speechManager
    self.networkService = networkService
    self.keyService = keyService
    self.tokenNetwork = tokenNetwork

    getUserCardDetails()
    getLastThreeTransaction()
  }
  
  
  func requestCardDetail(api: String, headers: [String : String]) async throws {
    do {
      let response: CardModel = try await networkService.fetchData(urlString: api, headers: headers)

      await MainActor.run {
        userCard = response
      }
    } catch {
      print(error, "🔴❌")
    }
  }
  
  func getUserCardDetails() {
    let api = EndpointsEnums.singleCard.rawValue
    
    Task {
      do {
        let token = try keyService.retrieveAccessToken()
        
        let headers = ["Authorization": "Bearer \(token)"]
        
        do {
          try await requestCardDetail(api: api, headers: headers)
        } catch {
          if case NetworkError.statusCodeError(statusCode: let statusCode) = error,
             statusCode == 401 {
            try await tokenNetwork.getNewToken()
            
            let newToken = try keyService.retrieveAccessToken()
            
            let updatedHeaders = ["Authorization": "Bearer \(newToken)"]
            try await requestCardDetail(api: api, headers: updatedHeaders)
          } else {
            throw error
          }
        }
      } catch {
        print(error, "🔴0")
      }
    }
  }
  
  func requestLastTransaction(api: String, headers: [String : String]) async throws {
    do {
      let response: [TransactionModel] = try await networkService.fetchData(urlString: api, headers: headers)
      await MainActor.run {
        let finalResponse = response.prefix(3)
        transactions.append(contentsOf: finalResponse)
      }
    } catch {
      print(error, "🔴❌")
    }
  }
  
  func getLastThreeTransaction() {
    let api = EndpointsEnums.transactions.rawValue
    
    Task {
      do {
        let token = try keyService.retrieveAccessToken()
        
        let headers = ["Authorization": "Bearer \(token)"]
        
        do {
          try await requestLastTransaction(api: api, headers: headers)
        } catch {
          if case NetworkError.statusCodeError(statusCode: let statusCode) = error,
             statusCode == 401 {
            try await tokenNetwork.getNewToken()
            
            let newToken = try keyService.retrieveAccessToken()
            
            let updatedHeaders = ["Authorization": "Bearer \(newToken)"]
            try await requestLastTransaction(api: api, headers: updatedHeaders)
          } else {
            throw error
          }
        }
      } catch {
        print(error, "🔴")
      }
    }
  }
  
  
  func mainAuido() {
    speechManager?.stopSpeaking()
    speechManager?.speakText(text: SpeechTextEnums.main.rawValue)
  }
  
  func balanceAudio(amount: Double) {
    speechManager?.stopSpeaking()
    speechManager?.speakText(text: "\(SpeechTextEnums.checkBalance.rawValue) \(amount).")
  }
  
  func lastFiveTransactionAudio() {
    speechManager?.stopSpeaking()
    
    let sum = transactions.reduce(0) { $0 + $1.amount}
    
    speechManager?.speakText(text: "\(SpeechTextEnums.lastTransactions.rawValue) \(sum).")
  }
  
  func stopAllAudio() {
    speechManager?.stopSpeaking()
  }
}

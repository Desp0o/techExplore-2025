//
//  TransactionsViewModel.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import Combine
import Foundation
import NetworkManagerFramework

final class TransactionsViewModel: ObservableObject {
  private let speechManager: SpeechManager?
  private let networkService: NetworkServiceProtocol
  private var debounceTimer: DispatchWorkItem?
  private let keyService: KeychainService
  private let tokenNetwork: TokenNetwork
  @Published var tapCounts = 0
  @Published var transactionsSum: Double = 0
  @Published var selectedIndices: Set<Int> = []
  @Published var transactions: [TransactionModel] = []
  
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
    
    getAllTransactions()
  }
  
  func requestTrasnactions(api: String, headers: [String : String]) async throws {
    do {
      let response: [TransactionModel] = try await networkService.fetchData(urlString: api, headers: headers)
      await MainActor.run {
        transactions.append(contentsOf: response)
      }
    } catch {
    }
  }
  
  func getAllTransactions() {
    let api = EndpointsEnums.transactions.rawValue
    
    Task {
      do {
        let token = try keyService.retrieveAccessToken()
        
        let headers = ["Authorization": "Bearer \(token)"]
        
        do {
          try await requestTrasnactions(api: api, headers: headers)
        } catch {
          if case NetworkError.statusCodeError(statusCode: let statusCode) = error,
             statusCode == 401 {
            try await tokenNetwork.getNewToken()
            
            let newToken = try keyService.retrieveAccessToken()
            
            let updatedHeaders = ["Authorization": "Bearer \(newToken)"]
            try await requestTrasnactions(api: api, headers: updatedHeaders)
          } else {
            throw error
          }
        }
      } catch {
        print(error, "🔴1")
      }
    }
  }
  
  
  func transactionsMainVoice() {
    speechManager?.speakText(text: SpeechTextEnums.transactionsMain.rawValue)
  }
  
  func transactionsSumVoice(quantity: Int = 0) {
    speechManager?.stopSpeaking()
    var sum: Double = 0
    
    if quantity == 0 {
      sum = transactions.reduce(0) { $0 + $1.amount }
      transactionsSum = sum
    } else {
      sum = transactions.prefix(quantity).reduce(0) { $0 + $1.amount }
      transactionsSum = sum
    }
    
    speechManager?.speakText(text: "\(SpeechTextEnums.totalTransactionsSum.rawValue) $\(String(format: "%.2f", sum))")
  }
  
  func handleTap() {
    if tapCounts < transactions.count {
      tapCounts += 1
    } else {
      tapCounts = transactions.count
    }
    
    debounceTimer?.cancel()
    
    debounceTimer = DispatchWorkItem {[weak self] in
      self?.transactionsSumVoice(quantity: self?.tapCounts ?? 0)
      self?.tapCounts = 0
    }
    
    if let debounceTimer = debounceTimer {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: debounceTimer)
    }
  }
  
  func trabsactionsCalculationOnTap(index: Int, amount: Double) {
    if selectedIndices.contains(index) {
      selectedIndices.remove(index)
      tapCounts -= 1
      transactionsSum -= amount
    } else {
      selectedIndices.insert(index)
      tapCounts += 1
      transactionsSum += amount
    }
  }
  
  func stopAllVoices() {
    speechManager?.stopSpeaking()
  }
}


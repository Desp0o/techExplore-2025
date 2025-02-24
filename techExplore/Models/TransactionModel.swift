//
//  TransactionCategory.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//

import Foundation
//
//enum TransactionCategory: String, CaseIterable, Codable {
//  case uncategorized = "Uncategorized"
//  case transfer = "Transfer"
//  case health = "Health"
//  case insurance = "Insurance"
//  case food = "Food"
//  case transport = "Transport"
//  case travel = "Travel"
//}

struct SenderModel: Codable {
  let id: Int
  let username: String
  let email: String
}

struct TransactionModel: Codable, Identifiable {
  let id: String
  let category: String
  let transactionDate: String
  let amount: Double
  let recipient: SenderModel
  let sender: SenderModel
  
  enum CodingKeys: String, CodingKey {
    case id
    case category
    case transactionDate = "transaction_date"
    case amount
    case recipient
    case sender
  }
}

//
//{
//    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//    "category": "Uncategorized",
//    "transaction_date": "2025-02-22T14:34:03.083Z",
//    "amount": 0,
//    "recipient": 0,
//    "sender": 0
//  }

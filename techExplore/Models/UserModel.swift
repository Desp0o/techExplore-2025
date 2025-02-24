//
//  UserModel.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//


struct UserModel: Codable {
  let id: Int
  let username: String
  let email: String
}

struct CardModel: Codable {
  let id: String
  let user: UserModel
  let name: String
  let category: String
  let issuer: String
  let balance: Double
  let createdAt: String?
}
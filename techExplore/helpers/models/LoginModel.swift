//
//  LoginModel.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

struct LoginModel: Codable {
  let email: String
  let password: String
}

struct LoginResponseModel: Codable {
  let refresh: String
  let access: String
}

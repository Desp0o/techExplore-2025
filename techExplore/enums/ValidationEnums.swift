//
//  ValidationEnums.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

enum ValidationError: String {
  case wrongUsername = "The first name must contain only letters"
  case shortUsername = "The first name must be at least 2 characters long"
  case wrongEmail = "Enter correct email format"
  case wrongPassword = "The password must contain at least one uppercase letter, one number, and one special character"
  case shortPassword = "The password must be at least 8 characters long."
  case passNoMatch = "The passwords do not match"
}

//
//  RegistrationViewModel.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import Combine

final class RegistrationViewModel: ObservableObject {
  @Published var userName = ""
  @Published var email = ""
  @Published var password = ""
  @Published var repeatPassword = ""
  @Published var isPasswordVisible = false
  @Published var isRepeatPasswordVisible = false
}

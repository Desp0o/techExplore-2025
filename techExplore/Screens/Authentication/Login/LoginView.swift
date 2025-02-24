//
//  LoginView.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import SwiftUI

struct LoginView: View {
  @ObservedObject var vm: LoginViewModel
  @EnvironmentObject var appVM: TechExploreViewModel
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  
  init(vm: LoginViewModel = LoginViewModel()) {
    self.vm = vm
  }
  
  var body: some View {
    VStack {
      Text("Login")
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText)
      
      Spacer().frame(height: 30)
      
      VStack(spacing: 12) {
        TextField("", text: $vm.email, prompt: Text("Enter email")
          .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark))
        .customStyledTextField(color: BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
        .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
        
        PasswordFieldReusable(
          passwordValue: $vm.password,
          isVisible: $vm.isPasswordVisible
        )
        
        Button {
          vm.loginRequest(isAuthenticated: appVM)
        } label: {
          Text("Login")
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(BlindnessEnums(rawValue: selectedType)?.customTint)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .tint(.white)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 20)
    .background(BlindnessEnums(rawValue: selectedType)?.customWhite.ignoresSafeArea())
    .overlay {
      if vm.isLoading {
        VStack {
          ProgressView()
            .scaleEffect(2)
            .tint(BlindnessEnums(rawValue: selectedType)?.customTint)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

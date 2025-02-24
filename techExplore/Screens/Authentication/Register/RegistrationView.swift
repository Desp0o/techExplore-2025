//
//  RegistrationView.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import SwiftUI

struct RegistrationView: View {
  @ObservedObject var vm: RegistrationViewModel
  
  init(vm: RegistrationViewModel = RegistrationViewModel()) {
    self.vm = vm
  }
  
  var body: some View {
    VStack {
      VStack(spacing: 12) {
        TextField(text: $vm.email) {
          Text("Enter email")
            .padding(.leading, 20)
        }
//        .customStyledTextField()
        
        TextField(text: $vm.email) {
          Text("Enter email")
            .padding(.leading, 20)
        }
//        .customStyledTextField()
        
        PasswordFieldReusable(
          passwordValue: $vm.password,
          isVisible: $vm.isPasswordVisible
        )
        
        PasswordFieldReusable(
          passwordValue: $vm.repeatPassword,
          isVisible: $vm.isRepeatPasswordVisible
        )
        
        Button {
        } label: {
          Text("Registration")
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .tint(.white)
        }
      }
    }
    .frame(maxHeight: .infinity)
    .padding(.horizontal, 20)
  }
}

#Preview {
  RegistrationView()
}

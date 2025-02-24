//
//  PasswordFieldReusable.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import SwiftUI

struct PasswordFieldReusable: View {
  @Binding var passwordValue: String
  @Binding var isVisible: Bool
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue

  var body: some View {
    ZStack(alignment: .trailing) {
      SecureField("", text: $passwordValue, prompt: Text("Enter password")
        .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText))
      .customStyledTextField(color: BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
      .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText)
      .opacity(isVisible ? 0 : 1)
      
      TextField("", text: $passwordValue, prompt: Text("Enter password")
        .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText))
        .customStyledTextField(color: BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
        .foregroundColor(BlindnessEnums(rawValue: selectedType)?.customText)
        .opacity(isVisible ? 1 : 0)
      
      Button {
        isVisible.toggle()
      } label: {
        Image(systemName: isVisible ? IconsEnums.eye.rawValue : IconsEnums.eyeSlash.rawValue)
          .tint(BlindnessEnums(rawValue: selectedType)?.customText)
      }
      .offset(x: -10)
    }
    
  }
}

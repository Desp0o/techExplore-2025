//
//  TextFieldModifier.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

import SwiftUI

extension TextField {
  func customStyledTextField(color: Color) -> some View {
    self.frame(height: 40)
      .padding(.horizontal, 12)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay(RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 1))
      .textInputAutocapitalization(.never)
  }
}

extension SecureField {
  func customStyledTextField(color: Color) -> some View {
    self.frame(height: 40)
      .padding(.horizontal, 12)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay(RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 1))
  }
}

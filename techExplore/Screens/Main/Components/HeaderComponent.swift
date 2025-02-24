//
//  HeaderComponent.swift
//  techExplore
//
//  Created by Despo on 22.02.25.
//

import SwiftUI

struct HeaderComponent: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  
  var body: some View {
    ZStack {
      HStack {}
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(BlindnessEnums(rawValue: selectedType)?.customDark.ignoresSafeArea())

        .shadow(color: .achroDark.opacity(0.25), radius: 5)
      
      HStack {
        ZStack {
          Text("TBC")
            .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
            .font(.title)
            .fontWeight(.bold)
        }
        .background(BlindnessEnums(rawValue: selectedType)?.customDark)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 60)
    }
  }
}

#Preview {
  HeaderComponent()
}

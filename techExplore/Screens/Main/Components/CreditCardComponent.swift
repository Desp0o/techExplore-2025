//
//  CreditCardComponent.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct CreditCardComponent: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue

  var body: some View {
    VStack(alignment: .leading) {
      Text("საკრედიტო ბარათები")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
      
      CardReusableComponent(
        cardImage: "ertguli",
        cardName: "ერთგული",
        cardBalance: "360",
        textColor: BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark,
        cardTextColor: BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark
      )
      
      Divider()
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
  }
}

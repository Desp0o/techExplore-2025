//
//  TransactionComponent.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct TransactionComponent: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue

  let icon: String
  let companyName: String
  let category: String
  let amount: String
  let textColor: Color
  
  var body: some View {
    HStack {
      ZStack {
        Image(systemName: icon)
          .resizable()
          .renderingMode(.template)
          .frame(width: 32, height: 32)
          .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
      }
      .frame(width: 50, height: 50)
      .background(BlindnessEnums(rawValue: selectedType)?.customDark)
      .clipShape(Circle())
      
      VStack(alignment: .leading) {
        Group {
          Text(companyName)
          Text(category)
        }
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
      }
      
      Spacer()
      
      Text(amount)
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
        .fontWeight(.semibold)
    }
  }
}


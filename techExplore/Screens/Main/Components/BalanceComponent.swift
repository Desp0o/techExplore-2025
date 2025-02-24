//
//  BalanceView.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct BalanceComponent: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  @EnvironmentObject var vm: HomeViewModel
  
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text("ხელმისაწვდომი")
            .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customWhiteText ?? .achroDark)
          
          Text(String(format: "%.2f", vm.userCard?.balance ?? 0))
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
        }
        
        Spacer()
      }
      
      CardReusableComponent(
        cardImage: "visa",
        cardName: vm.userCard?.category ?? "",
        cardBalance: String(format: "%.2f", vm.userCard?.balance ?? 0),
        textColor: BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark,
        cardTextColor: BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark
      )
    }
    .padding(20)
    .frame(maxWidth: .infinity)
    .background(BlindnessEnums(rawValue: selectedType)?.customDark)
    .clipShape(RoundedRectangle(cornerRadius: 8))
    .padding(20)
    .shadow(color: .achroDark.opacity(0.25), radius: 5)
  }
}

//
//  LastThreeTransactionComponent.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

//enum category: String {
//  case
//}

import SwiftUI

struct LastThreeTransactionComponent: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  @EnvironmentObject var vm: HomeViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("ბოლო გადახდები")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
      
      VStack {
        ForEach(vm.transactions, id: \.id) { transaction in
          TransactionComponent(
            icon: IconsEnums.getIcon(for: transaction.category),
            companyName: transaction.recipient.username,
            category: transaction.category,
            amount: String(format: "%.2f", transaction.amount),
            textColor: BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark
          )
          
          Divider()
        }
        
        Spacer()
          .frame(height: 30)
        
        NavigationLink {
          TransactionsView()
        } label: {
          Text("ყველა ტრანზაქცია")
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 40)
            .background(.ultraThinMaterial)
            .background(BlindnessEnums(rawValue: selectedType)?.customTint)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }
      .padding(.bottom, 20)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
  }
}

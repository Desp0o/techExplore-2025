//
//  CardReusableComponent.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct CardReusableComponent: View {
  let cardImage: String
  let cardName: String
  let cardBalance: String
  let textColor: Color
  let cardTextColor: Color
  
  var body: some View {
    HStack {
      Image(cardImage)
        .resizable()
        .frame(width: 70, height: 50)
      
      VStack(alignment: .leading) {
        Text("ბარათი")
          .foregroundStyle(cardTextColor)
        Text(cardName)
          .foregroundStyle(textColor)
      }
      
      Spacer()
      
      Text("\(cardBalance) ₾")
        .fontWeight(.bold)
        .foregroundStyle(textColor)
    }
  }
}

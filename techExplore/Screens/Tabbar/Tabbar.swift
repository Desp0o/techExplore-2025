//
//  Tabbar.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct Tabbar: View {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  @State private var currentIdenx = 0
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        switch currentIdenx {
        case 0:
          HomeView()
        case 1:
          SettingsView()
        default:
          HomeView()
        }
      }
      
      HStack {
        Button {
          currentIdenx = 0
        } label: {
          VStack {
            Image(systemName: IconsEnums.home.rawValue)
              .renderingMode(.template)
            
            Text("მთავარი")
              .font(.subheadline)
          }
          .foregroundStyle(currentIdenx == 0 ? BlindnessEnums(rawValue: selectedType)?.customTint ?? .blue : .gray )
        }
        
        Spacer()
        
        Button {
          currentIdenx = 1
        } label: {
          VStack {
            Image(systemName: IconsEnums.settings.rawValue)
              .renderingMode(.template)
            
            Text("პარამეტრები")
              .font(.subheadline)
          }
          .foregroundStyle(currentIdenx == 1 ? BlindnessEnums(rawValue: selectedType)?.customTint ?? .blue : .gray )
        }
      }
      .padding(.bottom, 10)
      .padding(.horizontal, 70)
      .frame(maxWidth: .infinity)
      .frame(height: 80)
      .background(BlindnessEnums(rawValue: selectedType)?.customDark)
    }
    .ignoresSafeArea(.container, edges: .bottom)
  }
}

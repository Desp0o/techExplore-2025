//
//  SettingsView.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct SettingsView: View {
  @StateObject var theme = ThemeManager()
  @StateObject var vm = SettingsViewModel()
  @EnvironmentObject var appVM: TechExploreViewModel

  var body: some View {
    NavigationStack {
      VStack {
        Toggle("ხმოვანი ასისტენტი", isOn: $vm.isAssistantOn)
          .foregroundStyle(theme.currentBlindnessType.customText)
        
        HStack {
          Text("თემა")
            .foregroundStyle(theme.currentBlindnessType.customText)
          
          Spacer()
          
          Picker("Blindness Type", selection: $theme.selectedType) {
            ForEach(BlindnessEnums.allCases, id: \.self) { type in
              Text(type.rawValue.capitalized)
                .tag(type.rawValue)
            }
          }
          .pickerStyle(.menu)
        }
        
        HStack {
          Circle()
            .fill(theme.currentBlindnessType.customDark)
            .frame(width: 30, height: 30)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
          
          Circle()
            .fill(theme.currentBlindnessType.customWhite)
            .frame(width: 30, height: 30)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
          
          Circle()
            .fill(theme.currentBlindnessType.customTint)
            .frame(width: 30, height: 30)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
          
          Circle()
            .fill(theme.currentBlindnessType.customWhiteText)
            .frame(width: 30, height: 30)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
        }
        
        Spacer()
          .frame(height: 100)
        
        Button(action: {
          vm.logOut()
          appVM.logOut()
        }) {
          Text("გასვლა")
            .foregroundStyle(theme.currentBlindnessType.customText)
            .frame(width: 100, height: 40)
            .background(theme.currentBlindnessType.customTint)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(theme.currentBlindnessType.customWhite)
    }
  }
}

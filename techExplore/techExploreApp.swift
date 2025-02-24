//
//  techExploreApp.swift
//  techExplore
//
//  Created by Despo on 18.02.25.
//

import SwiftUI

@main
struct techExploreApp: App {
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  @StateObject private var appVM = TechExploreViewModel()
  
  var body: some Scene {
    WindowGroup {
      VStack {
        if appVM.isUserLogged {
          NavigationStack {
            Tabbar()
              .environmentObject(appVM)
          }
        } else {
          NavigationStack {
            LoginView()
              .environmentObject(appVM)
          }
        }
      }
      .overlay(
        ZStack {
          if appVM.isLoading {
            BlindnessEnums(rawValue: selectedType)?.customWhite
              .ignoresSafeArea()
            
            ProgressView()
              .scaleEffect(2)
              .tint(BlindnessEnums(rawValue: selectedType)?.customTint)
          }
        }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      )
    }
  }
}


//
//  BlindnessSettings.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

class ThemeManager: ObservableObject {
  @Published var selectedType: String {
    didSet {
      UserDefaults.standard.set(selectedType, forKey: "selectedBlindnessType")
    }
  }
  
  init() {
    self.selectedType = UserDefaults.standard.string(forKey: "selectedBlindnessType") ?? BlindnessEnums.light.rawValue
  }
  
  var currentBlindnessType: BlindnessEnums {
    BlindnessEnums(rawValue: selectedType) ?? .light
  }
}

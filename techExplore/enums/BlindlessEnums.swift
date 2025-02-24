//
//  BlindlessEnums.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

enum BlindnessEnums: String, CaseIterable {
  case light
  case protanopia
  case deuteranopia
  case tritanopia
  case achromatopsia
  case monochromacy
  
  var customWhite: Color {
    switch self {
    case .light: return Color.customWhite
    case .protanopia: return Color.protanWhite
    case .deuteranopia: return Color.deutWhite
    case .tritanopia: return Color.tritaWhite
    case .achromatopsia: return Color.achroWhite
    case .monochromacy: return Color.monoWhite
    }
  }
  
  var customDark: Color {
    switch self {
    case .light: return Color.primaryWhite
    case .protanopia: return Color.protanDark
    case .deuteranopia: return Color.deutDark
    case .tritanopia: return Color.tirtaDark
    case .achromatopsia: return Color.achroDark
    case .monochromacy: return Color.monoDark
    }
  }
  
  var customTint: Color {
    switch self {
    case .light: return Color.lightTint
    case .protanopia: return Color.protanTint
    case .deuteranopia: return Color.deutTint
    case .tritanopia: return Color.tritaTint
    case .achromatopsia: return Color.achroTint
    case .monochromacy: return Color.monoTint
    }
  }
  
  var customText: Color {
    switch self {
    case .light: return Color.protanDark
    case .protanopia: return Color.protanDark
    case .deuteranopia: return Color.deutDark
    case .tritanopia: return Color.tirtaDark
    case .achromatopsia: return Color.achroDark
    case .monochromacy: return Color.monoDark
    }
  }
  
  var customWhiteText: Color {
    switch self {
    case .light: return Color.protanDark
    case .protanopia: return Color.protanWhite
    case .deuteranopia: return Color.deutWhite
    case .tritanopia: return Color.tritaWhite
    case .achromatopsia: return Color.achroWhite
    case .monochromacy: return Color.monoWhite
    }
  }
}

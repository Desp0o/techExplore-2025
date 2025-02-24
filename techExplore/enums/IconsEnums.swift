//
//  IconsEnums.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

enum IconsEnums: String {
  case eye = "eye"
  case eyeSlash = "eye.slash"
  case arrowBack = "arrow.backward.circle.fill"
  case home = "house"
  case settings = "gear"
  case checkMark = "checkmark.circle.fill"
  case food = "fork.knife.circle"
  case transport = "car.circle"
  case travel = "airplane.circle"
  case health = "cross.circle"
  case insurance = "newspaper.circle"
  case transfer = "arrow.up.left.and.arrow.down.right.circle"
  case uncategorized = "questionmark.circle"
  case shopping = "cart.circle"
  
  static func getIcon(for category: String) -> String {
    switch category.lowercased() {
    case "food": return IconsEnums.food.rawValue
    case "transport": return IconsEnums.transport.rawValue
    case "travel": return IconsEnums.travel.rawValue
    case "health": return IconsEnums.health.rawValue
    case "insurance": return IconsEnums.insurance.rawValue
    case "transfer": return IconsEnums.transfer.rawValue
    case "shopping": return IconsEnums.shopping.rawValue
    default: return IconsEnums.uncategorized.rawValue
    }
  }
}

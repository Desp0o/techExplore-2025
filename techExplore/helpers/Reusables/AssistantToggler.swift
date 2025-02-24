//
//  AssistantToggler.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct AssistantToggler: View {
  @Binding var isAssistantOn: Bool
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue

  var body: some View {
    VStack(alignment: .leading) {
      Text("გსურთ ხმოვანი ასისტენტი?")
        .fontWeight(.bold)
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
      
      Toggle("ჩართვა", isOn: $isAssistantOn)
        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
    }
  }
}

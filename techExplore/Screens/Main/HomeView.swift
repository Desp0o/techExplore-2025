//
//  HomeView.swift
//  techExplore
//
//  Created by Despo on 20.02.25.
//

import SwiftUI

struct HomeView: View {
  var vm: HomeViewModel
  @State private var navigateToTransactions = false
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  
  init(vm: HomeViewModel = HomeViewModel()) {
    self.vm = vm
  }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        HeaderComponent()
        
        ScrollView {
          BalanceComponent()
          CreditCardComponent()
          LastThreeTransactionComponent()
        }
        .padding(.bottom, -8)
        .scrollIndicators(.hidden)
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .highPriorityGesture(
        TapGesture(count: 2)
          .onEnded { _ in
            if vm.isAssistantOn {
              vm.stopAllAudio()
              navigateToTransactions = true
            }
          }
      )
      .gesture(
        SpatialTapGesture()
          .onEnded { _ in
            if vm.isAssistantOn {
              vm.balanceAudio(amount: vm.userCard?.balance ?? 0)
            }
          }
      )
      .gesture(
        LongPressGesture()
          .onEnded { _ in
            if vm.isAssistantOn {
              vm.lastFiveTransactionAudio()
            }
          }
      )
      .background(BlindnessEnums(rawValue: selectedType)?.customWhite)
      .navigationDestination(isPresented: $navigateToTransactions) {
        TransactionsView()
      }
      .navigationBarHidden(true)
      .onAppear {
        if vm.isAssistantOn {
          Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
              vm.mainAuido()
            }
          }
        }
      }
      .onDisappear {
        vm.stopAllAudio()
      }
      .environmentObject(vm)
    }
  }
}

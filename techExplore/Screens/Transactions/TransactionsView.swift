//
//  TransactionsView.swift
//  techExplore
//
//  Created by Despo on 21.02.25.
//

import SwiftUI

struct TransactionsView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var vm =  TransactionsViewModel()
  @AppStorage("selectedBlindnessType") var selectedType = BlindnessEnums.light.rawValue
  @AppStorage("isAssistantEnabled") private var isAssistantOn = false
  
  var body: some View {
    ZStack {
      BlindnessEnums(rawValue: selectedType)?.customWhite.ignoresSafeArea()
      
      VStack {
        ScrollView {
          HStack {
            Image(systemName: IconsEnums.arrowBack.rawValue)
              .renderingMode(.template)
              .resizable()
              .frame(width: 36, height: 36)
              .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
              .highPriorityGesture(
                TapGesture()
                  .onEnded({ _ in
                    presentationMode.wrappedValue.dismiss()
                  })
              )
            
            Spacer()
          }
          
          Text("ტრანზაქციები")
            .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
            .fontWeight(.semibold)
            .font(.title2)
          
          VStack {
            ForEach(vm.transactions.indices, id: \.self) { index in
              let transaction = vm.transactions[index]
              
              TransactionComponent(
                icon: IconsEnums.getIcon(for: transaction.category),
                companyName: transaction.recipient.username,
                category: transaction.category,
                amount: String(transaction.amount),
                textColor: BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark
              )
              .overlay {
                HStack {
                  if vm.selectedIndices.contains(index) {
                    ZStack {
                      Image(systemName: IconsEnums.checkMark.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customTint ?? .achroDark)
                        .frame(width: 52, height: 52)
                    }
                    .background(BlindnessEnums(rawValue: selectedType)?.customWhite)
                    
                    Spacer()
                  }
                }
              }
              .onTapGesture {
                if !isAssistantOn {
                  vm.trabsactionsCalculationOnTap(index: index, amount: transaction.amount)
                }
              }
              Divider()
            }
          }
          .zIndex(20)
        }
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .gesture(DragGesture()
        .onEnded { value in
          if value.translation.width > 50 {
            presentationMode.wrappedValue.dismiss()
          }
        }
      )
      .onLongPressGesture{
        if isAssistantOn {
          vm.transactionsSumVoice()
        }
      }
      .simultaneousGesture(
        isAssistantOn ? TapGesture().onEnded { _ in vm.handleTap() } : nil
      )
      .navigationBarBackButtonHidden(true)
      .overlay{
        if !isAssistantOn {
          VStack() {
            HStack {
              Text("ტრანზაქციები: \(vm.tapCounts)")
                .fontWeight(.semibold)
              Spacer()
              Text("ჯამი: \(String(format: "%.2f", vm.transactionsSum))")
                .fontWeight(.semibold)
            }
            .foregroundStyle(BlindnessEnums(rawValue: selectedType)?.customText ?? .achroDark)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(BlindnessEnums(rawValue: selectedType)?.customTint)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 20)
            .opacity(vm.tapCounts > 0 ? 1 : 0)
            
            Spacer()
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
      .onAppear {
        if isAssistantOn {
          Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
              vm.transactionsMainVoice()
            }
          }
        }
      }
      .onDisappear {
        if isAssistantOn {
          vm.stopAllVoices()
        }
      }
    }
  }
}

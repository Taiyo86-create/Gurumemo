//
//  Home.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI

struct Home: View {
  @State var showLogoutAlert: Bool = false
  @StateObject var homeViewModel = HomeViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Spacer()
          Button(action: {
            showLogoutAlert = true
          }) {
            Image(systemName: AppConstant.logoutIcon)
              .font(.system(size: 25))
              .padding()
          }
        }
        
        VStack(spacing: 20) {
          TextField(AppConstant.wantEat, text: $homeViewModel.genre)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
          
          VStack(alignment: .leading) {
            Text(AppConstant.creditCardTitle)
              .font(.headline)
            Picker(AppConstant.creditCardTitle, selection: $homeViewModel.selectedCreditCard) {
              ForEach(homeViewModel.creditCardOptions.keys.sorted(), id: \.self) { key in
                Text(key)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
          }
          
          VStack(alignment: .leading) {
            Text(AppConstant.budgetTitle)
              .font(.headline)
            Picker(AppConstant.budgetTitle, selection: $homeViewModel.selectedBudget) {
              ForEach(homeViewModel.budgetOptions.keys.sorted(), id: \.self) { key in
                Text(key)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
          }
          
          VStack(alignment: .leading) {
            Text(AppConstant.wifiTitle)
              .font(.headline)
            Picker(AppConstant.wifiTitle, selection: $homeViewModel.selectedWifi) {
              ForEach(homeViewModel.wifiOptions.keys.sorted(), id: \.self) { key in
                Text(key)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
          }
          
          VStack(alignment: .leading) {
            Text(AppConstant.freeDrinkTitle)
              .font(.headline)
            Picker(AppConstant.freeDrinkTitle, selection: $homeViewModel.selectedFreeDrink) {
              ForEach(homeViewModel.freeDrinkOptions.keys.sorted(), id: \.self) { key in
                Text(key)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
          }
          
          VStack(alignment: .leading) {
            Text(AppConstant.freeFoodTitle)
              .font(.headline)
            Picker(AppConstant.freeFoodTitle, selection: $homeViewModel.selectedFreeFood) {
              ForEach(homeViewModel.freeFoodOptions.keys.sorted(), id: \.self) { key in
                Text(key)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
          }
          
          Button {
            homeViewModel.loadShop()
          } label: {
            Text(AppConstant.search)
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)
              .cornerRadius(10)
          }
        }
        .padding()
        Spacer()
      }
      .alert(isPresented: $showLogoutAlert) {
        Alert(
          title: Text(AppConstant.promptLogout),
          primaryButton: .destructive(Text(AppConstant.yesButton)) {
            homeViewModel.signOut()
          },
          secondaryButton: .cancel(Text(AppConstant.noButton)) {
            showLogoutAlert = false
          }
        )
      }
      .onAppear {
        homeViewModel.isLoading = true
      }
      .navigationDestination(isPresented: $homeViewModel.isLogout) {
        Login().toolbar(.hidden)
      }
    }
  }
}

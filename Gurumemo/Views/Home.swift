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
            Text("クレジットカード")
              .font(.headline)
            Picker("クレジットカード", selection: $homeViewModel.selectedCreditCard) {
              ForEach(homeViewModel.creditCardOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
          }
          
          VStack(alignment: .leading) {
            Text("予算")
              .font(.headline)
            Picker("予算", selection: $homeViewModel.selectedBudget) {
              ForEach(homeViewModel.budgetOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
          }
          
          VStack(alignment: .leading) {
            Text("Wi-Fiの有無")
              .font(.headline)
            Picker("Wi-Fi", selection: $homeViewModel.selectedWifi) {
              ForEach(homeViewModel.wifiOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
          }
          
          VStack(alignment: .leading) {
            Text("飲み放題")
              .font(.headline)
            Picker("飲み放題", selection: $homeViewModel.selectedFreeDrink) {
              ForEach(homeViewModel.freeDrinkOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
          }
          
          VStack(alignment: .leading) {
            Text("食べ放題")
              .font(.headline)
            Picker("食べ放題", selection: $homeViewModel.selectedFreeFood) {
              ForEach(homeViewModel.freeFoodOptions, id: \.self) {
                Text($0)
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
      NavigationLink(
        destination: Login().toolbar(.hidden),
        isActive: Binding(
          get: { homeViewModel.isLogout },
          set: { homeViewModel.isLogout = $0 }
        ),
        label: {
          EmptyView()
        })
    }
  }
}

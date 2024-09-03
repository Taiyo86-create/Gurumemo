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
            print(homeViewModel.isLogout)
          }) {
            Image(systemName: AppConstant.logoutIcon)
              .font(.system(size: 25))
              .padding()
          }
        }
        VStack {
        }
        .padding()
        Spacer()
      }
      .alert(isPresented: $showLogoutAlert) {
        Alert(
          title: Text("ログアウトしますか？"),
          primaryButton: .destructive(Text("はい")) {
            homeViewModel.signOut()
          },
          secondaryButton: .cancel(Text("いいえ")) {
            showLogoutAlert = false
          }
        )
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

#Preview {
  Home()
}

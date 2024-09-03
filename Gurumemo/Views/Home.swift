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
          TextField("何が食べたい？", text: $homeViewModel.genre)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
          
          Button {
            homeViewModel.loadShop()
          } label: {
            Text("検索")
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)
              .cornerRadius(10)
          }
        }
        .padding()
        ScrollView {
          ForEach(homeViewModel.homeModel.names.indices, id: \.self) { index in
            VStack(alignment: .leading) {
              Text(homeViewModel.homeModel.names[index])
                .font(.headline)
              Text(homeViewModel.homeModel.addresses[index])
                .font(.subheadline)
              AsyncImage(url: URL(string: homeViewModel.homeModel.imageUrls[index])) { image in
                image.resizable()
                  .scaledToFit()
                  .frame(width: 150)
                  .frame(height: 150)
              } placeholder: {
              }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
          }
        }
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

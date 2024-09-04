//
//  Home.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI
import MapKit

struct Home: View {
  @State var showLogoutAlert: Bool = false
  @StateObject var homeViewModel = HomeViewModel()
  @StateObject var locationManager = LocationManager()
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
          TextField(AppConstant.wantEat, text: $homeViewModel.genre)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
          
          Text(AppConstant.whereEat)
          
          Map(coordinateRegion: locationManager.region,
              showsUserLocation: true,
              userTrackingMode: $trackingMode
          )
            .frame(height: 300)
          
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
        if homeViewModel.isloading {
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
        } else {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.blue)
        }
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
        homeViewModel.isloading = true
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

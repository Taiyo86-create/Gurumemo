//
//  HomeViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import FirebaseAuth

class HomeViewModel: ObservableObject {
  @Published var isLogout:Bool = false
  @Published var genre: String = ""
  @Published var homeModel = HomeModel()
  @Published var isloading: Bool = false
  
  init() {
    observeAuthChanges()
  }
  //  認証情報を確認
  private func observeAuthChanges() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      DispatchQueue.main.async {
        self?.isLogout = user != nil
      }
    }
  }
  //  ログアウトのメソッド
  func signOut() {
    do {
      try Auth.auth().signOut()
      isLogout = true
    } catch _ as NSError {
    }
  }
  func loadShop() {
    isloading = false
    APIClient().fetchShop(keyword: genre) { names, addresses, imageUrls in
      DispatchQueue.main.async {
        self.homeModel = HomeModel(names: names, addresses: addresses, imageUrls: imageUrls)
      }
    }
    isloading = true
  }
}

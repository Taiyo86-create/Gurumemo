//
//  HomeViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import FirebaseAuth

class HomeViewModel: ObservableObject {
  @Published var isLogout: Bool = false
  @Published var genre: String = ""
  @Published var homeModel = HomeModel()
  @Published var isLoading: Bool = false
  
  // 新しい状態変数
  @Published var selectedCreditCard = "Visa"
  @Published var selectedBudget = "2000円以下"
  @Published var selectedWifi = "あり"
  @Published var selectedFreeDrink = "なし"
  @Published var selectedFreeFood = "なし"
  
  let creditCardOptions = ["Visa", "MasterCard", "American Express"]
  let budgetOptions = ["2000円以下", "2000円〜5000円", "5000円以上"]
  let wifiOptions = ["あり", "なし"]
  let freeDrinkOptions = ["あり", "なし"]
  let freeFoodOptions = ["あり", "なし"]
  
  init() {
    observeAuthChanges()
  }
  
  private func observeAuthChanges() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      DispatchQueue.main.async {
        self?.isLogout = user != nil
      }
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      isLogout = true
    } catch _ as NSError {
    }
  }
  
  func loadShop() {
    isLoading = false
    APIClient().fetchShop(keyword: genre) { names, addresses, imageUrls in
      DispatchQueue.main.async {
        self.homeModel = HomeModel(names: names, addresses: addresses, imageUrls: imageUrls)
      }
    }
    isLoading = true
  }
}

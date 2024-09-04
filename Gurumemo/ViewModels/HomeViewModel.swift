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
  @Published var homeModel = HomeModel()
  @Published var isLoading: Bool = false
  
  @Published var genre: String = ""
  @Published var selectedCreditCard = "Visa"
  @Published var selectedBudget = "2000円以下"
  @Published var selectedWifi = "あり"
  @Published var selectedFreeDrink = "なし"
  @Published var selectedFreeFood = "なし"
  
  let creditCardOptions = ["Visa": "c01", "MasterCard": "c02", "American Express": "c04"]
  let budgetOptions = ["2000円以下": "B001", "2000円〜5000円": "B002", "5000円以上": "B003"]
  let wifiOptions = ["あり": "1", "なし": "0"]
  let freeDrinkOptions = ["あり": "1", "なし": "0"]
  let freeFoodOptions = ["あり": "1", "なし": "0"]
  
  init() {
    observeAuthChanges()
  }
  
  private func observeAuthChanges() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      DispatchQueue.main.async {
        self?.isLogout = user == nil
      }
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      isLogout = true
    } catch {
      print("Sign out error: \(error.localizedDescription)")
    }
  }
  
  func loadShop() {
    isLoading = true
    APIClient().fetchShop(
      keyword: genre,
      creditCard: creditCardOptions[selectedCreditCard] ?? "",
      budget: budgetOptions[selectedBudget] ?? "",
      wifi: wifiOptions[selectedWifi] ?? "0",
      freeDrink: freeDrinkOptions[selectedFreeDrink] ?? "0",
      freeFood: freeFoodOptions[selectedFreeFood] ?? "0"
    ) { names, addresses, imageUrls in
      DispatchQueue.main.async {
        self.homeModel = HomeModel(names: names, addresses: addresses, imageUrls: imageUrls)
        self.isLoading = false
      }
    }
  }
}

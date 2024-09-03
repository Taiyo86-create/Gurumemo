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
  
  init() {
    //    インスタンスが生成されたら認証情報を確認
    observeAuthChanges()
  }
  
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
      print("エラー")
    }
  }
}

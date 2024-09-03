//
//  SignUpViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
  @Published var isAuth:Bool = false
  
  init() {
    //    インスタンスが生成されたら認証情報を確認
    observeAuthChanges()
  }
  
  private func observeAuthChanges() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      DispatchQueue.main.async {
        self?.isAuth = user != nil
      }
    }
  }
  
  //  新規登録する関数
  func signUp(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
      DispatchQueue.main.async {
        if result != nil, error == nil {
          self?.isAuth = true
        }
      }
    }
  }
}


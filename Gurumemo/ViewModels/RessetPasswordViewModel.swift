//
//  RessetPasswordViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import FirebaseAuth

class RessetPasswordViewModel: ObservableObject {
  //  パスワードをリセットする関数
  func resetPassword(email: String) {
    Auth.auth().sendPasswordReset(withEmail: email) { error in
      if error != nil {
        print("error")
      }
    }
  }
}

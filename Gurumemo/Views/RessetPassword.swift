//
//  RessetPassword.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI

struct RessetPassword: View {
  @State var email = ""
  @StateObject var ressetPasswordViewModel = RessetPasswordViewModel()
  var body: some View {
    TextField(AppConstant.registerEmail, text: $email)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .padding(.horizontal, 30)
      .padding(.bottom, 10)
    
    Button(action: {
      ressetPasswordViewModel.resetPassword(email: email)
    }) {
      Text(AppConstant.submitEmail)
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal, 30)
    }
  }
}

#Preview {
  RessetPassword()
}

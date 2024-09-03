//
//  SignUp.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI

struct SignUp: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @StateObject var signInViewModel = SignInViewModel()
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: AppConstant.signUpLogo)
          .resizable()
          .frame(width: 80, height: 80)
          .foregroundColor(.blue)
          .padding(.bottom, 20)
        
        TextField(AppConstant.email, text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal, 30)
          .padding(.bottom, 10)
        
        SecureField(AppConstant.password, text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal, 30)
          .padding(.bottom, 10)
        
        NavigationLink {
          Login().toolbar(.hidden)
        } label: {
          Text(AppConstant.linkLogin)
        }
        
        Button(action: {
          signInViewModel.signUp(email: email, password: password)
        }) {
          Text(AppConstant.signUp)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal, 30)
        }
      }
      NavigationLink(
        destination: Home().toolbar(.hidden),
        isActive: Binding(
          get: { signInViewModel.isAuth },
          set: { signInViewModel.isAuth = $0 }
        ),
        label: {
          EmptyView()
        })
    }
  }
}

#Preview {
  SignUp()
}

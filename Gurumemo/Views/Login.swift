//
//  Login.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI

struct Login: View {
  @State var email: String = ""
  @State var password: String = ""
  @StateObject var loginViewModel = LoginViewModel()
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: AppConstant.loginLogo)
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
          .padding(.bottom, 20)
        
        NavigationLink {
          SignUp().toolbar(.hidden)
        } label: {
          Text(AppConstant.linkSignUp)
        }
        
        NavigationLink {
          RessetPassword()
        } label: {
          Text(AppConstant.linkPasswordResset)
        }
        
        Button(action: {
          loginViewModel.signIn(email: email, password: password)
        }) {
          Text(AppConstant.login)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal, 30)
        }
        NavigationLink(
          destination: Home().toolbar(.hidden),
          isActive: Binding(
            get: { loginViewModel.isAuth },
            set: { loginViewModel.isAuth = $0 }
          ),
          label: {
            EmptyView()
          })
      }
    }
  }
}

#Preview {
  Login()
}

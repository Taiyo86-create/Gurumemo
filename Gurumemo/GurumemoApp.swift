//
//  GurumemoApp.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import SwiftUI
import FirebaseCore

@main
struct GurumemoApp: App {
  init() {
    FirebaseApp.configure()
  }
    var body: some Scene {
        WindowGroup {
            Login()
        }
    }
}

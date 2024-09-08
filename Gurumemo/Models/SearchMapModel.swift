//
//  SearchMapModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/08.
//

import Foundation

struct SearchMapModel {
  let latitude: Double
  let longitude: Double
  
  func saveRange(latitude: Double, longitude: Double) {
    UserDefaults.standard.set(latitude ,forKey: "savedLatitude")
    UserDefaults.standard.set(longitude ,forKey: "savedLongitude")
  }
}

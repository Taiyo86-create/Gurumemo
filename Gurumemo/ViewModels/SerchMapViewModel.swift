//
//  SerchMapViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/08.
//

import Foundation

class SerchMapViewModel: ObservableObject {
  @Published var isButtonTap: Bool = false
  @Published var savedLatitude: Double = 0.0
  @Published var savedLongitude: Double = 0.0
  
  func updateLocation(latitude: Double, longitude: Double) {
    savedLatitude = latitude
    savedLongitude = longitude
    print("Updated Location - Latitude: \(latitude), Longitude: \(longitude)")
  }
  
  func saveRange() {
    SearchMapModel(latitude: Double(), longitude: Double()).saveRange(latitude: savedLatitude, longitude: savedLongitude)
    isButtonTap = true
  }
}

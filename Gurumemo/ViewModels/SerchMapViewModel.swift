//
//  SerchMapViewModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/08.
//

import Foundation

class SerchMapViewModel: ObservableObject {
  @Published var isSerchButtonTap: Bool = false
  var searchModel = SearchMapModel()
  
  func saveRange() {
    searchModel.saveRange()
    isSerchButtonTap = true
  }
}

//
//  HomeModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation

class HomeModel {
  var names: [String]
  var addresses: [String]
  var imageUrls: [String]
  
  init(names: [String] = [], addresses: [String] = [], imageUrls: [String] = []) {
    self.names = names
    self.addresses = addresses
    self.imageUrls = imageUrls
  }
}

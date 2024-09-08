//
//  SearchMapModel.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/08.
//

import Foundation
import RealmSwift

class SearchMapModel: Object {
  @Persisted var latitude: Double = 0.0
  @Persisted var longitude: Double = 0.0
  
  convenience init(latitude: Double, longitude: Double) {
    self.init()
    self.latitude = latitude
    self.longitude = longitude
  }
  
  func saveRange() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self)
    }
  }
}

//
//  APIClient.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
  var name: String = ""
  var address: String = ""
  var imageURL: String = ""
  
  func fetchShop() {
    let apiKey = "f5b83e0df3d9cd01"
    let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let keywordEncoded = "パスタ".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "\(baseUrl)?key=\(apiKeyEncoded)&large_area=Z011&format=json&count=1&keyword=\(keywordEncoded)"
    
    if let url = URL(string: urlString) {
      AF.request(url)
        .responseJSON { response in
          switch response.result {
          case .success(let value):
            let json = JSON(value)
            let shopData = json["results"]["shop"].arrayValue.first
            if let shopData = shopData {
              self.name = shopData["name"].stringValue
              self.address = shopData["address"].stringValue
              self.imageURL = shopData["photo"]["pc"]["l"].stringValue
            }
          case .failure(let error):
            print(error)
          }
        }
    }
  }
}

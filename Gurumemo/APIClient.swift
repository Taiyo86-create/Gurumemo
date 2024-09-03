//
//  APIClient.swift
//  Gurumemo
//
//  Created by 水元太陽 on 2024/09/03.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIClient {
  func fetchShop(keyword: String, completion: @escaping ([String], [String], [String]) -> Void) {
    let apiKey = "f5b83e0df3d9cd01"
    let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let keywordEncoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "\(baseUrl)?key=\(apiKeyEncoded)&large_area=Z011&format=json&count=10&keyword=\(keywordEncoded)"
    
    if let url = URL(string: urlString) {
      AF.request(url)
        .responseJSON { response in
          switch response.result {
          case .success(let value):
            let json = JSON(value)
            let shopArray = json["results"]["shop"].arrayValue
            var names: [String] = []
            var addresses: [String] = []
            var imageUrls: [String] = []
            
            for shopData in shopArray {
              let name = shopData["name"].stringValue
              let address = shopData["address"].stringValue
              let imageURL = shopData["photo"]["pc"]["l"].stringValue
              names.append(name)
              addresses.append(address)
              imageUrls.append(imageURL)
              print("成功: 店舗名: \(name), 住所: \(address), 画像URL: \(imageURL)")
            }
            
            // クロージャーを呼び出して結果を返す
            completion(names, addresses, imageUrls)
          case .failure(let error):
            print("API Request Error: \(error)")
            // エラー時に空の値を返す
            completion([], [], [])
          }
        }
    }
  }
}

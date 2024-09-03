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
  
  func fetchShop() {
    let apiKey = "f5b83e0df3d9cd01"
    let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let keywordEncoded = "ラーメン".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
}

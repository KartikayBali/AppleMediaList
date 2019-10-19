//
//  APIManager.swift
//  AppleMediaList
//
//  Created by Bali on 18/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
  
  static let baseURL = "https://rss.itunes.apple.com/"
  static let apiPrefix = "api/v1/"
  static let URL = "\(baseURL)\(apiPrefix)"
  
  class func fetchData(callBack: @escaping (_ result: Feed?, _ error: String?) -> Void) {
    let mediaType = getRequiredString(givenString: UserDataManager.shared.mediaType.rawValue)
    let feedType = getRequiredString(givenString: UserDataManager.shared.feedType.rawValue)
    let endURL = "us/\(mediaType)/\(feedType)/\(UserDataManager.shared.genre)/\(UserDataManager.shared.resultLimit)/\(UserDataManager.shared.explicitText).json"
    Alamofire.request(URL + endURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
      
      if let jsonD = response.result.value as? Dictionary<String, AnyObject>, let feedD = jsonD["feed"] as? [String: Any] {
        let feed = Feed(data: feedD)
        callBack(feed, nil)
      } else {
        callBack(nil, response.error?.localizedDescription)
      }
    }
  }
  
  class func getRequiredString(givenString s: String) -> String {
    return s.components(separatedBy: " ").map({ $0.lowercased() }).joined(separator: "-")
  }
}

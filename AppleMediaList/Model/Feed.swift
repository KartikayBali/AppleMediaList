//
//  Feed.swift
//  AppleMediaList
//
//  Created by Bali on 18/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

class Feed {
  var title = ""
  var id = ""
  var country = ""
  var icon = ""
  var updatedAt = Date()
  
  var items = [Media]()
  
  init(data: [String: Any]) {
    if let value = data["title"] as? String {
      title = value
    }
    
    if let value = data["id"] as? String {
      id = value
    }
    
    if let value = data["country"] as? String {
      country = value
    }
    
    if let value = data["icon"] as? String {
      icon = value
    }
    
    if let value = data["updated"] as? Date {
      updatedAt = value
    }
    
    if let values = data["results"] as? [[String: Any]] {
      items = [Media]()
      for value in values {
        let media = Media(data: value)
        items.append(media)
      }
    }
  }
}

//
//  Media.swift
//  AppleMediaList
//
//  Created by Bali on 18/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

class Media {
  var artistName = ""
  var id = ""
  var releaseDate = ""
  var name = ""
  var kind = ""
  var copyright = ""
  var artistId = ""
  var contentAdvisoryRating = ""
  var artistUrl = ""
  var artworkUrl100 = ""
  var url = ""
  
  var genres = [String]()
  
  init(data: [String: Any]) {
    if let value = data["artistName"] as? String {
      artistName = value
    }
    
    if let value = data["id"] as? String {
      id = value
    }
    
    if let value = data["releaseDate"] as? String {
      releaseDate = value
    }
    
    if let value = data["name"] as? String {
      name = value
    }
    
    if let value = data["kind"] as? String {
      kind = value
    }
    
    if let value = data["copyright"] as? String {
      copyright = value
    }
    
    if let value = data["artistId"] as? String {
      artistId = value
    }
    
    if let value = data["contentAdvisoryRating"] as? String {
      contentAdvisoryRating = value
    }
    
    if let value = data["artistUrl"] as? String {
      artistUrl = value
    }
    
    if let value = data["artworkUrl100"] as? String {
      artworkUrl100 = value
    }
    
    if let value = data["url"] as? String {
      url = value
    }
    
    if let values = data["genres"] as? [String] { // Needed if implementing genres
      genres = values
    }
  }
}

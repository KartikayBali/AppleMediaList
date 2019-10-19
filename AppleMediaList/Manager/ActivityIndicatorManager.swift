//
//  ActivityIndicatorManager.swift
//  AppleMediaList
//
//  Created by Bali on 18/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation
import SVProgressHUD

class ActivityIndicatorManager {
  static let shared: ActivityIndicatorManager = {
    let instance = ActivityIndicatorManager()
//    SVProgressHUD.setDefaultStyle(.custom)
//    SVProgressHUD.setBackgroundLayerColor(UIColor.clear)
//    SVProgressHUD.setBackgroundColor(UIColor.clear)
//    SVProgressHUD.setForegroundColor(UIColor.lightGray)
//    SVProgressHUD.setRingThickness(3.0)
//    SVProgressHUD.setRingRadius(6.0)
    return instance
  }()
  
  func show() {
    SVProgressHUD.setDefaultMaskType(.none)
    SVProgressHUD.show()
  }
  
  func dismiss() {
    DispatchQueue.global(qos: .default).async {
      DispatchQueue.main.async {
        SVProgressHUD.dismiss()
      }
    }
  }
}

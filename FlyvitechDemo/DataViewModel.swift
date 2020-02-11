//
//  DataViewModel.swift
//  FlyvitechDemo
//
//  Created by Ram Gade on 2020/02/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import SwiftUI

public class DataViewModel:ObservableObject {
  
  @Published var dataList = [ResponseData]()
  @Published var headerTitle = ""
  
  init() {
    fetchDataFromServer()
  }
  
  func fetchDataFromServer() {
    NetworkManager.sharedIntance.getData { (responseObject, response, error) in
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      if httpResponse.statusCode == Endpoints.successStatus {
        DispatchQueue.main.async { [weak self] in
          self?.dataList = responseObject?.result ?? []
          self?.headerTitle = responseObject?.headerTitle ?? ""
        }
      } else {
        // Error condition
        UIAlertControllerForAlert.sharedInstance.showAlertOnMainWindow(title: "Error", message:"Server error occured, Please try later")
      }
    }
  }
}

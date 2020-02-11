//
//  NetworkManager.swift
//  FlyvitechDemo
//
//  Created by Ram Gade on 2020/02/07.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

public typealias CompletionHandler = (_ data: RootData?,_ response: URLResponse?,_ error: Error?)->()

import Foundation
import ObjectMapper

public class NetworkManager {
  
  static let sharedIntance = NetworkManager()//Singleton
  
  private init(){
    
  }
  
  public func getData( _ completion: @escaping CompletionHandler) {
    guard let url = URL(string:Endpoints.baseUrl) else { return }
    URLSession.shared.dataTask(with: url) {(data,response,error) in
      do {
        if let listData = data {
          let utf8Data = String(decoding: listData, as: UTF8.self).data(using: .utf8)
          let json = try? JSONSerialization.jsonObject(with: utf8Data!, options: [])
          let report = try Mapper<RootData>().map(JSON: json as! [String : Any])
          completion(report, response, error)
        } else {
          print("No Data")
          completion(nil, response, error)
        }
      } catch {
        print ("Error")
        completion(nil, response, error)
      }
    }.resume()
  }
}

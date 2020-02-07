//
//  NetworkManager.swift
//  FlyvitechDemo
//
//  Created by Ram Gade on 2020/02/07.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import ObjectMapper

public class NetworkManager: ObservableObject {
  
    let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    @Published var dataList = [Data]()
    @Published var headerTitle = ""
    static let sharedIntance = NetworkManager()
    
    private init(){
        load()
    }
    
    func load() {
        let url = URL(string:baseUrl)!
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let listData = data {
                    let utf8Data = String(decoding: listData, as: UTF8.self).data(using: .utf8)
                    let json = try? JSONSerialization.jsonObject(with: utf8Data!, options: [])
                    let report = try Mapper<RootData>().map(JSON: json as! [String : Any])
                    DispatchQueue.main.async {
                        self.dataList = report.result ?? []
                        self.headerTitle = report.headerTitle ?? ""
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
        }.resume()
        
    }
}

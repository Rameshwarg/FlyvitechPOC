//
//  ContentView.swift
//  FlyvitechDemo
//
//  Created by Ram Gade on 2020/02/06.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import SwiftUI
import ObjectMapper
import struct Kingfisher.KFImage

struct ContentView: View {
    
    @ObservedObject var fetcher = MovieFetcher()
    var refreshControl = UIRefreshControl()
    
    var body: some View {
        NavigationView {
            List(fetcher.movies) { cellData in
                KFImage(URL(string:cellData.imageHref ?? ""))
                    .resizable()
                    .frame(width: 100, height: 100).cornerRadius(50)
                VStack(alignment: .leading) {
                    Text(cellData.title ?? "")
                    Text(cellData.description ?? "").font(.subheadline).colorMultiply(.red)
                }
            }.navigationBarTitle(Text(fetcher.hearderTitle))
        }
    }
    
    func initialize() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
}

public class MovieFetcher: ObservableObject {
    
    @Published var movies = [Data]()
    @Published var hearderTitle = ""
    
    init(){
        load()
    }
    
    func load() {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let listData = data {
                    
                    let utf8Data = String(decoding: listData, as: UTF8.self).data(using: .utf8)
                    
                    let json = try? JSONSerialization.jsonObject(with: utf8Data!, options: [])
                    let report = try Mapper<RootData>().map(JSON: json as! [String : Any])
                    DispatchQueue.main.async {
                        self.movies = report.result ?? []
                        self.hearderTitle = report.headerTitle ?? ""
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

#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
#endif








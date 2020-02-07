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
    
    @ObservedObject var data = NetworkManager.sharedIntance
    
    let imageSize:CGFloat = 100
    
    var body: some View {
        NavigationView {
            List(self.data.dataList) { cellData in
                
                //                KFImage(URL(string:cellData.imageHref ?? "")).placeholder {
                //                    Image(systemName: "arrow.2.circlepath.circle")
                //                        .font(.largeTitle)
                //                        .opacity(0.3)
                //                }
                KFImage(URL(string:cellData.imageHref ?? ""))
                    .onSuccess { r in
                        
                }
                .onFailure { e in }
                .placeholder {
                    Image(systemName: "placeholder.png").font(.largeTitle)
                    .opacity(0.3)
                }
                .resizable()
                .frame(width: self.imageSize, height: self.imageSize).cornerRadius(self.imageSize/2)
                
                VStack(alignment: .leading) {
                    Text(cellData.title ?? "")
                    Text(cellData.description ?? "").font(.subheadline).colorMultiply(.red)
                }
            }.navigationBarTitle(Text(data.hearderTitle))
        }
    }
}

#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
#endif








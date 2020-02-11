//
//  Data.swift
//  FlyvitechDemo
//
//  Created by Ram Gade on 2020/02/06.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import ObjectMapper

public struct RootData {
  let result : [ResponseData]?
  let headerTitle:String?
}

extension RootData: ImmutableMappable {
  public init(map: Map) throws {
    result = try? map.value("rows")
    headerTitle = try? map.value("title")
  }
}

struct ResponseData:Identifiable {
  var id = UUID()
  let title: String?
  let description: String?
  let imageHref: String?
}

extension ResponseData: ImmutableMappable {
  public init(map: Map) throws {
    title = try? map.value("title")
    description = try? map.value("description")
    imageHref = try? map.value("imageHref")
  }
}

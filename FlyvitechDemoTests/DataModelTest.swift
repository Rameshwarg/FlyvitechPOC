//
//  DataModelTest.swift
//  FlyvitechDemoTests
//
//  Created by Ram Gade on 2020/02/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import XCTest
@testable import FlyvitechDemo

class DataModelTest: XCTestCase {
  
  var dataModel:DataViewModel!
  
  override func setUp() {
  }
  
  override func tearDown() {
      dataModel = nil
      super.tearDown()
  }
  
  func testGetData() {
    _ = expectation(description: "Get data from server")
    dataModel = DataViewModel()
    XCTAssertTrue(dataModel.dataList.count > 0, "Got the data from server")
    XCTAssertNotNil(dataModel.headerTitle, "Hearder text should not be nil")
    
    waitForExpectations(timeout: 10) { (error) in
      guard let error = error else { return }
      XCTFail("\(error)")
    }
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
  
}

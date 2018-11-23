//
//  FireManagerTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 22/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

class FireManagerTests: XCTestCase {
    
    var imageManager: FireManager<UIImage>!
    var stringManager: FireManager<String>!
    var jsonManager: FireManager<JSON>!

    override func setUp() {
        super.setUp()
        imageManager = .init()
        stringManager = .init()
        jsonManager = .init()
    }
    
    override func tearDown() {
        imageManager.invalidate()
        stringManager.invalidate()
        jsonManager.invalidate()
        super.tearDown()
    }
}

//
//  FireCacheTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 22/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

class FireCacheTests: XCTestCase {

    var imageCache: FireCache<UIImage>!
    var stringCache: FireCache<String>!
    var jsonCache: FireCache<JSON>!

    override func setUp() {
        super.setUp()
        imageCache = .init()
        stringCache = .init()
        jsonCache = .init()
    }

    override func tearDown() {
        imageCache.clearMemoryCache()
        stringCache.clearMemoryCache()
        jsonCache.clearMemoryCache()
        super.tearDown()
    }

    func testMaxMemorySize() {
        imageCache.maxMemoryCost = 1
        stringCache.maxMemoryCost = 2
        jsonCache.maxMemoryCost = 3
        XCTAssertEqual(imageCache.maxMemoryCost, 1)
        XCTAssertEqual(stringCache.maxMemoryCost, 2)
        XCTAssertEqual(jsonCache.maxMemoryCost, 3)
    }
    
    func testExpiryCheckTimeInterval() {
        imageCache.expiryCheckTimeInterval = 30
        stringCache.expiryCheckTimeInterval = 40
        jsonCache.expiryCheckTimeInterval = 50
        XCTAssertEqual(imageCache.expiryCheckTimeInterval, 30)
        XCTAssertEqual(stringCache.expiryCheckTimeInterval, 40)
        XCTAssertEqual(jsonCache.expiryCheckTimeInterval, 50)
    }
    
    func testCacheLifeSpan() {
        imageCache.cacheLifeSpan = 25
        stringCache.cacheLifeSpan = 35
        jsonCache.cacheLifeSpan = 45
        XCTAssertEqual(imageCache.cacheLifeSpan, 25)
        XCTAssertEqual(stringCache.cacheLifeSpan, 35)
        XCTAssertEqual(jsonCache.cacheLifeSpan, 45)
    }
    
    func testClearMemoryCache() {
        
        let key = "HelperDataImageKey"
        let testImage: UIImage = UIImage(data: testImageData)!
        let expectation = self.expectation(description: "Waiting for retrieving image")

        imageCache.storeObject(testImage, forKey: key) {
            self.imageCache.clearMemoryCache()
            let cachedImage = self.imageCache.retrieveObject(forKey: key)
            XCTAssertNil(cachedImage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("Wait for retrieving image - Expectations Timeout errored: \(error)")
            }
        }
    }
}

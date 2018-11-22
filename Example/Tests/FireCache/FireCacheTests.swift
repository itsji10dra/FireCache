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

    var cache: FireCache<UIImage>!
    
    override func setUp() {
        super.setUp()
        cache = .init()
    }

    override func tearDown() {
        cache.clearMemoryCache()
        super.tearDown()
    }

    func testMaxMemorySize() {
        cache.maxMemoryCost = 1
        XCTAssertEqual(cache.maxMemoryCost, 1)
    }
    
    func testExpiryCheckTimeInterval() {
        cache.expiryCheckTimeInterval = 30
        XCTAssertEqual(cache.expiryCheckTimeInterval, 30)
    }
    
    func testCacheLifeSpan() {
        cache.cacheLifeSpan = 25
        XCTAssertEqual(cache.cacheLifeSpan, 25)
    }
    
    func testStoreObject() {

        let expectation = self.expectation(description: "Waiting for retrieving image")

        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey1"
        let image = UIImage(named: "test-sample-1", in: testBundle, compatibleWith: nil)!
        
        cache.storeObject(image, forKey: bundleImageKey) {
            let cachedImage = self.cache.retrieveObject(forKey: bundleImageKey)
            XCTAssertNotNil(cachedImage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testRemoveObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving image")
        
        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey2"
        let image = UIImage(named: "test-sample-2", in: testBundle, compatibleWith: nil)!
        
        cache.storeObject(image, forKey: bundleImageKey)
        cache.removeObject(forKey: bundleImageKey) {
            let cachedImage = self.cache.retrieveObject(forKey: bundleImageKey)
            XCTAssertNil(cachedImage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving image - Expectations Timeout errored: \(error)")
            }
        }
    }

    func testContainsObject() {

        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey3"
        let image = UIImage(named: "test-sample-3", in: testBundle, compatibleWith: nil)!

        cache.storeObject(image, forKey: bundleImageKey)
        XCTAssertTrue(cache.containsObject(forKey: bundleImageKey))
    }
    
    func testClearMemoryCache() {
        
        let key = "HelperDataImageKey"
        let testImage: UIImage = UIImage(data: testImageData)!
        let expectation = self.expectation(description: "Waiting for retrieving image")

        cache.storeObject(testImage, forKey: key) {
            self.cache.clearMemoryCache()
            let cachedImage = self.cache.retrieveObject(forKey: key)
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

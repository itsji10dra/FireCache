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

// MARK: - UIImage

extension FireCacheTests {
    
    func testStoreImageObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving image")
        
        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey1"
        let image = UIImage(named: "test-sample-1", in: testBundle, compatibleWith: nil)!
        
        imageCache.storeObject(image, forKey: bundleImageKey) {
            let cachedImage = self.imageCache.retrieveObject(forKey: bundleImageKey)
            XCTAssertNotNil(cachedImage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testRemoveImageObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving image")
        
        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey2"
        let image = UIImage(named: "test-sample-2", in: testBundle, compatibleWith: nil)!
        
        imageCache.storeObject(image, forKey: bundleImageKey)
        imageCache.removeObject(forKey: bundleImageKey) {
            let cachedImage = self.imageCache.retrieveObject(forKey: bundleImageKey)
            XCTAssertNil(cachedImage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testContainsImageObject() {
        
        let testBundle = Bundle(for: type(of: self))
        let bundleImageKey = "ImageKey3"
        let image = UIImage(named: "test-sample-3", in: testBundle, compatibleWith: nil)!
        
        imageCache.storeObject(image, forKey: bundleImageKey)
        XCTAssertTrue(imageCache.containsObject(forKey: bundleImageKey))
    }
}

// MARK: - String

extension FireCacheTests {
    
    func testStoreStringObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving string")
        
        let key = "Key1"
        let string = "QWERTYUIOPASDFGHJKLZXCVBNM"
        
        stringCache.storeObject(string, forKey: key) {
            let cachedString = self.stringCache.retrieveObject(forKey: key)
            XCTAssertNotNil(cachedString)
            XCTAssertEqual(cachedString, string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testRemoveStringObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving string")
        
        let key = "Key2"
        let string = "QWERTYUIOPASDFGHJKLZXCVBNM"

        stringCache.storeObject(string, forKey: key)
        stringCache.removeObject(forKey: key) {
            let cachedString = self.stringCache.retrieveObject(forKey: key)
            XCTAssertNil(cachedString)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testContainsStringObject() {
        
        let key = "Key3"
        let string = "QWERTYUIOPASDFGHJKLZXCVBNM"

        stringCache.storeObject(string, forKey: key)
        XCTAssertTrue(stringCache.containsObject(forKey: key))
    }
}

// MARK: - JSON

extension FireCacheTests {
    
    func testStoreJSONObject() {
        
        let expectation = self.expectation(description: "Waiting for retrieving JSON")
        
        let key = "Key1"
        let stringJSON = """
{
    "name":"John",
    "age":30,
    "cars": [
        { "name":"Ford", "models":[ "Fiesta", "Focus", "Mustang" ] },
        { "name":"BMW", "models":[ "320", "X3", "X5" ] },
        { "name":"Fiat", "models":[ "500", "Panda" ] }
    ]
 }
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }
        
        jsonCache.storeObject(json, forKey: key) {
            let cachedJSON = self.jsonCache.retrieveObject(forKey: key)
            XCTAssertNotNil(cachedJSON)
            XCTAssertNotNil(cachedJSON?.dictionary)
            XCTAssertNil(cachedJSON?.array)
            XCTAssertEqual((cachedJSON?.dictionary?["cars"] as? [AnyObject])?.count, 3)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testRemoveJSONObject() {

        let expectation = self.expectation(description: "Waiting for retrieving JSON")

        let key = "Key2"
        let stringJSON = """
{
    "fruit": "Apple",
    "size": "Large",
    "color": "Red"
}
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }

        jsonCache.storeObject(json, forKey: key)
        jsonCache.removeObject(forKey: key) {
            let cachedJSON = self.jsonCache.retrieveObject(forKey: key)
            XCTAssertNil(cachedJSON)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for retrieving JSON - Expectations Timeout errored: \(error)")
            }
        }
    }

    func testContainsJSONObject() {

        let key = "Key3"
        let stringJSON = """
{
    "greeting":"hello"
}
"""
        let data = stringJSON.data(using: .utf8)!
        var json: JSON!
        do {
            json = try JSON.convertFromData(data)
        } catch {
            XCTFail("Unable to create JSON")
        }

        jsonCache.storeObject(json, forKey: key)
        XCTAssertTrue(jsonCache.containsObject(forKey: key))
    }
}

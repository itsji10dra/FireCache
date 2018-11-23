//
//  FireCacheTests+UIImage.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

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

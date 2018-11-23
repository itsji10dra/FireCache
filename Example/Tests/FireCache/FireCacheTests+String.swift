//
//  FireCacheTests+String.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

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

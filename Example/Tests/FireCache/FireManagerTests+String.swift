//
//  FireManagerTests+String.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

extension FireManagerTests {
    
    func testFetchStringWithStringManager() {
        
        let expectation = self.expectation(description: "Wait for downloading string")
        
        stringManager.fetch(with: stringURL) { (string, url, error) in
            XCTAssertNotNil(string)
            XCTAssertNil(error)
            XCTAssertEqual(stringURL, url)
            
            let isCached = self.stringManager.cache.containsObject(forKey: stringURL.absoluteString)
            XCTAssertTrue(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testFetchImageWithStringManager() {
        
        let expectation = self.expectation(description: "Wait for downloading image")
        
        stringManager.fetch(with: imageURL) { (image, url, error) in
            XCTAssertNil(image)
            XCTAssertNotNil(error)
            XCTAssertEqual(imageURL, url)
            
            let isCached = self.stringManager.cache.containsObject(forKey: imageURL.absoluteString)
            XCTAssertFalse(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testFetchJSONWithStringManager() {
        
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        stringManager.fetch(with: jsonURL) { (json, url, error) in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
            XCTAssertEqual(jsonURL, url)
            
            let isCached = self.stringManager.cache.containsObject(forKey: jsonURL.absoluteString)
            XCTAssertTrue(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }

}

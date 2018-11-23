//
//  FireManagerTests+UIImage.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

extension FireManagerTests {
    
    func testFetchImageWithImageManager() {
        
        let expectation = self.expectation(description: "Wait for downloading image")
        
        imageManager.fetch(with: imageURL) { (image, url, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            XCTAssertEqual(imageURL, url)
            
            let isCached = self.imageManager.cache.containsObject(forKey: imageURL.absoluteString)
            XCTAssertTrue(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testFetchStringWithImageManager() {
        
        let expectation = self.expectation(description: "Wait for downloading string")
        
        imageManager.fetch(with: stringURL) { (image, url, error) in
            XCTAssertNil(image)
            XCTAssertNotNil(error)
            XCTAssertEqual(stringURL, url)
            
            let isCached = self.imageManager.cache.containsObject(forKey: stringURL.absoluteString)
            XCTAssertFalse(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testFetchJSONWithImageManager() {
        
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        imageManager.fetch(with: jsonURL) { (json, url, error) in
            XCTAssertNil(json)
            XCTAssertNotNil(error)
            XCTAssertEqual(jsonURL, url)
            
            let isCached = self.imageManager.cache.containsObject(forKey: jsonURL.absoluteString)
            XCTAssertFalse(isCached)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }

}

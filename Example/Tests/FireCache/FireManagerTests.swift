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
    
    override func setUp() {
        super.setUp()
        imageManager = .init()
    }
    
    override func tearDown() {
        imageManager.invalidate()
        super.tearDown()
    }
    
    func testFetchWithImage() {
        
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
    
    func testFetchWithString() {
        
        let expectation = self.expectation(description: "Wait for downloading image")
        
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
                XCTFail("Wait for downloading image - Expectations Timeout errored: \(error)")
            }
        }
    }
}

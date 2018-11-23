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
    
    var manager: FireManager<UIImage>!
    
    override func setUp() {
        super.setUp()
        manager = .init()
    }
    
    override func tearDown() {
        manager.invalidate()
        super.tearDown()
    }
    
    func testFetchWithImage() {
        
        let expectation = self.expectation(description: "Wait for downloading image")
        
        manager.fetch(with: imageURL) { (image, url, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            XCTAssertEqual(imageURL, url)
            
            let isCached = self.manager.cache.containsObject(forKey: imageURL.absoluteString)
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
        
        let urlToLoad = URL(string: "https://pastebin.com/raw/B75vJCLX")!

        manager.fetch(with: urlToLoad) { (image, url, error) in
            XCTAssertNil(image)
            XCTAssertNotNil(error)
            XCTAssertEqual(urlToLoad, url)
            
            let isCached = self.manager.cache.containsObject(forKey: urlToLoad.absoluteString)
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

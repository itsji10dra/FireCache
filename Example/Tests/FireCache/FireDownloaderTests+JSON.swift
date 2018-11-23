//
//  FireDownloaderTests+JSON.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache


extension FireDownloaderTests {
    
    func testDownloadJSON() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        _ = jsonDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = jsonDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageUsingJSONDownloader() {
        let expectation = self.expectation(description: "Wait for downloading Image")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!
        
        _ = jsonDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading Image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringUsingJSONDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = jsonDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
}


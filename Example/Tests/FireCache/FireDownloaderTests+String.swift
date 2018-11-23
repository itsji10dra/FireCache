//
//  FireDownloaderTests+String.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

extension FireDownloaderTests {
    
    func testDownloadString() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = stringDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(string)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = stringDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONUsingStringDownloader() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        _ = stringDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageUsingStringDownloader() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!
        
        _ = stringDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
}
